var page = require('webpage').create(), 
	loadInProgress = false;

page.onConsoleMessage = function(msg) {
  console.log(msg);
};

page.onLoadStarted = function() {
  if(!loadInProgress) {
  	console.log("Starting wordpress install...");
  }
  loadInProgress = true;
};
page.open('http://localhost:8089/wp-admin/install.php', function() {
  if(page.evaluate(function() {
    return !document.getElementById('setup');
  })) {
    console.log("Wordpress is already installed!");
    phantom.exit();
  }

  page.evaluate(function() {
    document.getElementById('weblog_title').value = "Test Site";
    document.getElementById('user_login').value = "admin";
    document.getElementById('pass1').value = "asd123";
    document.getElementById('pass2').value = "asd123";
    document.getElementById('admin_email').value = "admin@admin.com";

    document.getElementById('setup').submit();
  });

  var check = function() {
    if(page.evaluate(function() {
      return document.getElementById('setup') === null;
    })) {
      console.log("Wordpress installed! Credentials: admin/asd123");
      phantom.exit();
    };
  };

  setInterval(check, 500);
});