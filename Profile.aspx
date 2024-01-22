<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="team4.Profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <asp:Button runat="server" Text="Get number of present guests" OnClick="noofguests"></asp:Button>
             <br />
                        <asp:Label runat="server" Text="Enter id"></asp:Label>
            <asp:TextBox ID="remove" runat="server"></asp:TextBox><br />
            <asp:Button runat="server" Text="Remove a guest" OnClick="remove1"></asp:Button>
<br />
            <asp:Button runat="server" Text="set number of guests" OnClick="set"></asp:Button>
            <br />
            <asp:Button runat="server" Text="Room details" OnClick="room"></asp:Button>
            <br />
            <asp:Button runat="server" Text="Task" OnClick="task"></asp:Button>
            <br />
                        <asp:Button runat="server" Text="Devices" OnClick="device"></asp:Button>
<br />                        <asp:Button runat="server" Text="Finance and Communication" OnClick="fandc"></asp:Button>
<br />
        </div>
    </form>
</body>
</html>
