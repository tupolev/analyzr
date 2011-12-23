<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<analyzr.Models.CounterModel>" %>

<asp:Content ID="counterTitle" ContentPlaceHolderID="TitleContent" runat="server">
	Text Scanner
</asp:Content>

<asp:Content ID="counterContent" ContentPlaceHolderID="MainContent" runat="server">
<%: Html.ValidationSummary(false, "No se creó la cuenta. Corrija los errores e inténtelo de nuevo.") %>
    <% using (Html.BeginForm("Counter", "Home", FormMethod.Post)) { %>
    <p style="text-align: center">
        <%: Html.LabelFor(m => m.inputText) %><br/>
        <%: Html.TextAreaFor(m => m.inputText) %>
    </p>
    <p style="text-align: center">
        <%: Html.LabelFor(m => m.pricePerWord) %>
        <%: Html.TextBoxFor(m => m.pricePerWord) %>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <%: Html.LabelFor(m => m.pricePerLine) %>
        <%: Html.TextBoxFor(m => m.pricePerLine) %>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <%: Html.LabelFor(m => m.charsPerLine) %>
        <%: Html.TextBoxFor(m => m.charsPerLine) %>
    </p>
    <p>
            <input type="submit" value="Scan now!" />
    </p>
    <h3>Scan results</h3>
    <p>
    <%: Html.LabelFor(m => m.totalPriceUsingLines) %>&nbsp;&nbsp;
    <strong><%: ViewData["totalPriceUsingLines"]%></strong>
    </p>
    <p>
    <%: Html.LabelFor(m => m.totalPriceUsingLinesByCRLF) %>&nbsp;&nbsp;
    <strong><%: ViewData["totalPriceUsingLinesByCRLF"]%></strong>
    </p>
    <p>
    <%: Html.LabelFor(m => m.totalPriceUsingWords) %>&nbsp;&nbsp;
    <strong><%: ViewData["totalPriceUsingWords"] %></strong>
    </p>
    <p>
    <%: Html.LabelFor(m => m.countedLines) %>&nbsp;&nbsp;
    <strong><%: ViewData["countedLines"] %></strong>
    </p>
    <p>
    <%: Html.LabelFor(m => m.countedLinesByCRLF) %>&nbsp;&nbsp;
    <strong><%: ViewData["countedLinesByCRLF"] %></strong>
    </p>
    <p>
    <%: Html.LabelFor(m => m.countedWords) %>&nbsp;&nbsp;
    <strong><%: ViewData["countedWords"] %></strong>
    </p>
    <% } %>
</asp:Content>
