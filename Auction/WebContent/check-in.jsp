<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/main_template.dwt.jsp" codeOutsideHTMLIsLocked="true" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- InstanceBeginEditable name="doctitle" -->
<title>Check-In</title>
<!-- InstanceEndEditable -->

<link href="main.css" rel="stylesheet" type="text/css" />
<link href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
<!-- InstanceBeginEditable name="head" -->
<!-- InstanceEndEditable -->
</head>

<body class="oneColElsCtrHdr">

<div id="container">
  <div id="header" style=";">
    <div style="height: 160px; padding: 1em;">
      <div style="background-image: url(); background-repeat:no-repeat; display:block; float:left; height: 160px; width: 260px;"><a href="/"><img name="logo" src="http://www.crehst.org/wp-content/themes/crehst/images/header.png" alt="" style="border: 0;"/></a></div>
      <!-- InstanceBeginEditable name="Headline" -->
      <div style="font-size:3em; float:left;">Check-In</div>
      <!-- InstanceEndEditable --></div>
    <div class="nav-bar">
        <a href="/check-in.jsp">Check In</a>
        <a href="raise-your-program.jsp">Raise Your Program</a>
        <a href="lot-closing.jsp">Lot Closing</a>
        <a href="check-out.jsp">Check Out</a>
        <a href="accounts.jsp">Accounts</a>
        <a href="lots.jsp">Lots</a>
        <!-- <a href="payments.jsp">Payments</a>
        <a href="search.jsp">Search</a>
        <a href="#">Admin</a> -->
    </div>
<!-- end #header --></div>
  <div id="mainContent"><!-- InstanceBeginEditable name="Body" -->
    <ol>
      <li>Bidder gives their name to the user.
        <ol>
          <li>&quot;Welcome, what is your name?&quot;</li>
        </ol>
      </li>
      <li>User enters the bidder’s name and clicks submit.
        <ol>
          <li>
            <label>
              <input type="text" name="textfield" id="textfield" />
            </label>
          </li>
        </ol>
      </li>
      <li>Find the correct account
or make a new one.
  <ol>
          <li><a href="#">Account</a></li>
          <li><a href="#">Account</a></li>
          <li><a href="#">Account</a></li>
          <li><a href="#">Account</a></li>
          <li><a href="/accounts.jsp#create">Create a new account</a></li>
  </ol>
      </li>
      <li>Update all info on the account. 
        <ol>
          <li>&quot;OK, let's get your info. Are you still on ______ street?&quot;</li>
        </ol>
      </li>
      <li>Select a program from the stack and save the program number into the account.</li>
      <li>&quot;Happy bidding!&quot;</li>
    </ol>
  <!-- InstanceEndEditable -->
  <!-- end #mainContent --></div>
  <div id="footer">
    <p>Footer</p>
  <!-- end #footer --></div>
<!-- end #container --></div>
</body>
<!-- InstanceEnd --></html>
