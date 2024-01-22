<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tasks.aspx.cs" Inherits="team4.Tasks" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
<asp:Label runat="server" Text="Name">
</asp:Label><asp:TextBox ID="Name" runat="server"></asp:TextBox>
<br />
    <asp:Button runat="server" Text="Finish Task" OnClick="FinishTask"></asp:Button>
    <asp:Button runat="server" Text="Task Status" OnClick="TaskStatus"></asp:Button>

</div>
                <div>
<br />
<asp:Label runat="server" Text="Name">
</asp:Label><asp:TextBox ID="TaskId" runat="server"></asp:TextBox>
</asp:Label><asp:Calendar ID="date" runat="server"></asp:Calendar>

<br />
    <asp:Button runat="server" Text="Add Reminder" OnClick="AddReminder"></asp:Button>
    <asp:Button runat="server" Text="Add Deadline" OnClick="AddDeadline"></asp:Button>
        </div>
    </form>
</body>
</html>
