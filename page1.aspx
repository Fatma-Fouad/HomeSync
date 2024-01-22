<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="page1.aspx.cs" Inherits="team4.page1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <br />
            `
        <asp:Label runat="server" Text="Email">
        </asp:Label><asp:TextBox ID="email" runat="server"></asp:TextBox>
        <asp:Label runat="server" Text="password">
        </asp:Label><asp:TextBox ID="password" runat="server"></asp:TextBox>
        
         <br />
            
            <br />
            <asp:Button runat="server" Text="Sign-in" OnClick="Signin"></asp:Button>

        </div>
    </form>
</body>
</html>
