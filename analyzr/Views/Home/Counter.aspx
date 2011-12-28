<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<analyzr.Models.CounterModel>" %>

    <asp:Content ID="counterTitle" ContentPlaceHolderID="TitleContent" runat="server">
	    Analyzr :: Multipurpose text scanner and price calculator
    </asp:Content>

    <asp:Content ID="counterContent" ContentPlaceHolderID="MainContent" runat="server">
        <div id="main_container">
            <%: Html.ValidationSummary(false, "Some fields are incorrect. Please review all data and try again.") %>
            <% using (Html.BeginForm("Counter", "Home", FormMethod.Post)) { %>
            <div id="container_content">
                <div id="form_input" style="text-align: center; float: none;">
                    <div style="text-align: left; width: 100%;"><h3><%: Html.LabelFor(m => m.inputText) %></h3></div>
                    <div style="text-align: center">
                        <%: Html.TextAreaFor(m => m.inputText) %>
                    </div>
                    <div>&nbsp;</div>
                    <div style="text-align: center; width: 90%;  display: block;">
                        <div style="text-align: center;">
                            <div style="text-align: left; display:inline-block; height: 75px;">
                                <div class="form_line"><%: Html.LabelFor(m => m.pricePerWord) %></div>
                                <div class="form_line"><%: Html.LabelFor(m => m.pricePerLine) %></div>                        
                                <div class="form_line"><%: Html.LabelFor(m => m.charsPerLine) %></div>
                            </div>
                            <div style="text-align: left; display:inline-block; height: 75px;">
                                <div class="form_line"><%: Html.TextBoxFor(m => m.pricePerWord) %>&nbsp;&euro;</div>
                                <div class="form_line"><%: Html.TextBoxFor(m => m.pricePerLine) %>&nbsp;&euro;</div>
                                <div class="form_line"><%: Html.TextBoxFor(m => m.charsPerLine) %></div>
                            </div>
                        </div>
                        <div>&nbsp;</div>
                        <div>
                            <input type="submit" value="Scan now!" />
                        </div>
                        <div>&nbsp;</div>
                    </div>
                </div>
                                                                                                                                                                                                                                                        <div id="form_output">
            <hr/>
            <div style="text-align: left">
                <h3>Scan results</h3>
            </div>

            <div style="text-align: center; width: 90%;  display: block;">
                        <div style="text-align: center;">
                            <div style="width: 50%;text-align: left; display:inline-block; height: 75px;">
                                <div class="form_line"><%: Html.LabelFor(m => m.totalPriceUsingLines) %></div>
                                <div class="form_line"><%: Html.LabelFor(m => m.totalPriceUsingLinesByCRLF) %>&nbsp;&nbsp;</div>                        
                                <div class="form_line"><%: Html.LabelFor(m => m.totalPriceUsingWords) %>&nbsp;&nbsp;</div>
                                <div class="form_line"><%: Html.LabelFor(m => m.countedLines) %>&nbsp;&nbsp;</div>
                                <div class="form_line"><%: Html.LabelFor(m => m.countedLinesByCRLF) %>&nbsp;&nbsp;</div>
                                <div class="form_line"><%: Html.LabelFor(m => m.countedWords) %>&nbsp;&nbsp;</div>
                            </div>
                            <div style="width: 40%;text-align: left; display:inline-block; height: 75px;">
                                <div class="form_line"><strong><%: ViewData["totalPriceUsingLines"]%> &euro;</strong></div>
                                <div class="form_line"><strong><%: ViewData["totalPriceUsingLinesByCRLF"]%> &euro;</strong></div>
                                <div class="form_line"><strong><%: ViewData["totalPriceUsingWords"] %> &euro;</strong></div>
                                <div class="form_line"><strong><%: ViewData["countedLines"] %></strong></div>
                                <div class="form_line"><strong><%: ViewData["countedLinesByCRLF"] %></strong></div>
                                <div class="form_line"><strong><%: ViewData["countedWords"] %></strong></div>
                            </div>
                        </div>
                    </div>
            <div>
                &nbsp;
            </div>
        <hr/>
        </div>
            </div>
            <% } %>
        </div>
    </asp:Content>