<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Devices.aspx.cs" Inherits="team4.Devices" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <asp:Label runat="server" Text="Enter Device id"></asp:Label>
            <asp:TextBox ID="textbox1" runat="server"></asp:TextBox><br />
            <asp:Button runat="server" Text="View Charge " OnClick="view"></asp:Button>
            <asp:Label runat="server" Text="Enter Device id"></asp:Label>
<asp:TextBox ID="textbox2" runat="server"></asp:TextBox><br />
            <asp:Label runat="server" Text="Enter status"></asp:Label>
<asp:TextBox ID="textbox3" runat="server"></asp:TextBox><br />
            <asp:Label runat="server" Text="Enter battery"></asp:Label>
<asp:TextBox ID="textbox4" runat="server"></asp:TextBox><br />
            <asp:Label runat="server" Text="Enter location"></asp:Label>
<asp:TextBox ID="textbox5" runat="server"></asp:TextBox><br />
            <asp:Label runat="server" Text="Enter type"></asp:Label>
<asp:TextBox ID="textbox6" runat="server"></asp:TextBox><br />
            <asp:Button runat="server" Text="Add Device " OnClick="add"></asp:Button>
            <br />
            <asp:Button runat="server" Text="out of battery " OnClick="Out"></asp:Button>
            <br />
            <asp:Button runat="server" Text="set out of battery to charging" OnClick="sett"></asp:Button>
            <br />
            <asp:Button runat="server" Text="need charge" OnClick="loc"></asp:Button>
            <br />
            <br />
        </div>
    </form>
</body>
</html>
