<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Check-in</title>
<link href="jquery-ui.css" rel="stylesheet" type="text/css" />
<link href="main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jquery-1.9.1.js"></script>
<script type="text/javascript" src="jquery-ui.js"></script>
<script type="text/javascript" src="Lot.js"></script>
<script type="text/javascript" src="auction.js"></script>
<script type="text/javascript">
</script>
</head>

<body>
    <div id="messageHost" />
    <div>
      <form>
        <h1>Create a new lot</h1>
        <table width="100%" border="0" id="newLot">
                <tr>
                  <th scope="row">Title</th>
                  <td>
                    <input type="text" class="lot_title" name="title" id="title" />
                  </td>
                </tr>
                <tr> 
                  <th scope="row">Description</th>
                  <td>
                    <!-- <textarea name="description" class="lot_description" id="description" cols="" rows="5">testing</textarea> -->
                    <input type="text" class="lot_description" name="description" id="description"  />
                  </td>
                </tr>
                <tr>
                  <th scope="row">Contributor</th>
                  <td>
                    <input type="text" class="lot_contributor" name="contributor" id="contributor" />
                  </td>
                </tr>
                <tr>
                  <th scope="row">Declared value</th>
                  <td>
                    <input type="text" class="lot_declaredValue" name="declaredValue" id="declaredValue" />
                  </td>
                </tr>
                <tr>
                  <td />
                  <td><input name="save2" type="button" value="Save" onclick="javascript: save_onclick();"/>                    <input name="clear" type="reset" value="Clear" />
                  </td>
                </tr>
        </table>
      </form>
    </div>
    <div>
      <form>
        <h1>Edit a lot</h1>
        <table width="100%" border="0" id="newLot">
                <tr>
                  <th scope="row">Title</th>
                  <td>
                    <input type="text" class="lot_title" name="title" id="title" />
                  </td>
                </tr>
                <tr>
                  <th scope="row">Description</th>
                  <td>
                    <!-- <textarea name="description" class="lot_description" id="description" cols="" rows="5">testing</textarea> -->
                    <input type="text" class="lot_description" name="description" id="description"  />
                  </td>
                </tr>
                <tr>
                  <th scope="row">Contributor</th>
                  <td>
                    <input type="text" class="lot_contributor" name="contributor" id="contributor" />
                  </td>
                </tr>
                <tr>
                  <th scope="row">Declared value</th>
                  <td>
                    <input type="text" class="lot_declaredValue" name="declaredValue" id="declaredValue" />
                  </td>
                </tr>
                <tr>
                  <td />
                  <td>
                      <input name="save" type="button" value="Save" onclick="javascript: save_onclick();"/>
                      <input name="clear" type="reset" value="Clear" />
                  </td>
                </tr>
        </table>
      </form>
    </div>
    <div>
  <h1>List lots</h1>
  <p>
      <input type="button" name="button" id="button" value="Get lots" onclick="javascript: getLots_click();" />
  </p>
  <table width="100%" border="thin" id="lots_table" style="width:auto;">
  <tr>
    <th scope="col">Edit</th>
    <th scope="col">Delete</th>
    <th scope="col">ID</th>
    <th scope="col"><p>Title</p></th>
    <th scope="col">Description</th>
    <th scope="col">Contributor</th>
    <th scope="col">Declared Value</th>
    <th scope="col">Winner</th>
    <th scope="col">Final Value</th>
    <th scope="col">Status</th>
    <th scope="col">Created</th>
    <th scope="col">Modified</th>
  </tr>
<!--
  <tr>
    <td>Edit</td>
    <td>Delete</td>
    <td>ID</td>
    <td><p>Title</p></td>
    <td>Description</td>
    <td>Contributor</td>
    <td>Declared Value</td>
    <td>Winner</td>
    <td>Final Value</td>
    <td>Status</td>
    <td>Created</td>
    <td>Modified</td>
  </tr>
 -->
 </table>

  </div>
</body>
</html>