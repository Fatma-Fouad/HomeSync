<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="assignroom.aspx.cs" Inherits="team4.assignroom" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <asp:Label runat="server" Text="Enter room id"></asp:Label><br />
            <asp:TextBox ID="books" runat="server"></asp:TextBox>
            <asp:Button runat="server" Text="Book a room" OnClick="book"></asp:Button>
              <br />
            <br />
            <asp:Label runat="server" Text="Enter room id:"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <br />
            <asp:Label runat="server" Text="Enter Start date:"></asp:Label>
            <asp:Calendar ID="calender1" runat="server"></asp:Calendar>
            <asp:Label runat="server" Text="Enter End date:"></asp:Label>
            <asp:Calendar ID="calender2" runat="server"></asp:Calendar>
            <asp:Label runat="server" Text="Enter Action:"></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
            <br />
            <asp:Button runat="server" Text="Create" OnClick="create"></asp:Button>
            <br />
            <br />
            <asp:Label runat="server" Text="Enter location"></asp:Label><br />
            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
            <br />
            <asp:Label runat="server" Text="Enter status"></asp:Label><br />
            <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
            <br />
            <asp:Button runat="server" Text="Change" OnClick="change"></asp:Button>
            <br />
            <br />
            <asp:Button runat="server" Text="View not used rooms" OnClick="view"></asp:Button>
            <br />
            <br />
        </div>
    </form>
</body>
</html>
