<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FinanceandCommunication.aspx.cs" Inherits="team4.Finance_Communication" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <br />
<asp:Label runat="server" Text="Type">
</asp:Label><asp:TextBox ID="Type" runat="server"></asp:TextBox> <br />
<asp:Label runat="server" Text="amount">
</asp:Label><asp:TextBox ID="amount" runat="server"></asp:TextBox> <br />
<asp:Label runat="server" Text="status">
</asp:Label><asp:TextBox ID="status" runat="server"></asp:TextBox> <br />
<asp:Label runat="server" Text="date">
</asp:Label><asp:Calendar ID="date" runat="server"></asp:Calendar> <br />
<asp:Button runat="server" Text="receivetransaction" OnClick="receive"></asp:Button>


<br /> <br />
<asp:Label runat="server" Text="receiver idLabel1">
</asp:Label><asp:TextBox ID="receiver" runat="server"></asp:TextBox>
<br />
<asp:Label runat="server" Text="amount">
</asp:Label><asp:TextBox ID="amount1" runat="server"></asp:TextBox>
<br />
<asp:Label runat="server" Text="status">
</asp:Label><asp:TextBox ID="status1" runat="server"></asp:TextBox>
<br />
<asp:Label runat="server" Text="deadline">
</asp:Label><asp:Calendar ID="deadline" runat="server"></asp:Calendar>
<br />
<asp:Button runat="server" Text="Plan payment" OnClick="planPayment"></asp:Button>


<br /> <br />
<asp:Label runat="server" Text="receiver idLabel2">
</asp:Label><asp:TextBox ID="receiver1" runat="server"></asp:TextBox>
<br />
<asp:Label runat="server" Text="titel">
</asp:Label><asp:TextBox ID="titel" runat="server"></asp:TextBox>
<br />
<asp:Label runat="server" Text="content">
</asp:Label><asp:TextBox ID="content" runat="server"></asp:TextBox>
<br />
            <asp:Label runat="server" Text="Time Sent">
</asp:Label><asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>
<br />
            <asp:Label runat="server" Text="Time Received">
</asp:Label><asp:Calendar ID="Calendar2" runat="server"></asp:Calendar>
<br />

<asp:Button runat="server" Text="Send message" OnClick="send"></asp:Button>


<br /> <br />
<asp:Label runat="server" Text="sender idLabel3">
</asp:Label><asp:TextBox ID="receiver2" runat="server"></asp:TextBox> 
            <asp:Button runat="server" Text="Show message" OnClick="show"></asp:Button>
<br /> <br />
<asp:Button runat="server" Text="delete last message " OnClick="delete"></asp:Button>
        </div>
    </form>
</body>
</html>
