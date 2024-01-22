<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Page2.aspx.cs" Inherits="team4.Page2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br /><asp:Label runat="server" Text="email"></asp:Label><br />
            <asp:TextBox ID="email" runat="server"></asp:TextBox><br />
            <asp:Label runat="server" Text="Firstname"></asp:Label><br />
            <asp:TextBox ID="Firstname" runat="server"></asp:TextBox>
            <br /><asp:Label runat="server" Text="Lastname"></asp:Label><br />
            <asp:TextBox ID="Lastname" runat="server"></asp:TextBox>
            <br />
            <asp:Label runat="server" Text="Birthdate"></asp:Label><br />
            <asp:Calendar ID="Birthdate" runat="server"></asp:Calendar>
            <asp:Label runat="server" Text="Password"></asp:Label><br />
            <asp:TextBox ID="Password" runat="server"></asp:TextBox>
             <br /> <asp:Button runat="server" Text="Register" OnClick="Register"></asp:Button>
           <br />

        </div>
    </form>
</body>
</html>
