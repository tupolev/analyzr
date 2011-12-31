<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<analyzr.Models.CounterModel>" %>

    <asp:Content ID="counterTitle" ContentPlaceHolderID="TitleContent" runat="server">
	    Analyzr :: Multipurpose text scanner and price calculator
    </asp:Content>

    <asp:Content ID="counterContent" ContentPlaceHolderID="MainContent" runat="server">
        <div id="main_container">
            <%: Html.ValidationSummary(false, "Some fields are incorrect. Please review all data and try again.") %>
            <% using (Html.BeginForm("counter", "home", FormMethod.Post, new { id = "forminput", enctype = "multipart/form-data" }))
               { %>
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
                                <div class="form_line"><label for="uploadFile">Document file to translate (only docx format)</label></div>
                            </div>
                            <div style="text-align: left; display:inline-block; height: 75px;">
                                <div class="form_line"><%: Html.TextBoxFor(m => m.pricePerWord) %>&nbsp;&euro;</div>
                                <div class="form_line"><%: Html.TextBoxFor(m => m.pricePerLine) %>&nbsp;&euro;</div>
                                <div class="form_line"><%: Html.TextBoxFor(m => m.charsPerLine) %></div>
                                <div class="form_line"><input name="uploadFile" type="file" /></div>
                            </div>
                        </div>
                        <div>&nbsp;</div>
                        <div>
                            <input type="submit" value="Scan now!" id="submit_button"/>
                        </div>
                        <div>&nbsp;</div>
                    </div>
                </div>
        <% String _display = "", _output_text = ""; %>
        <% if ((ViewData["output_generated"] != null) && ViewData["output_generated"].Equals(true))
           { 
                _display = "inherit";
                _output_text = (ViewData["file_text"] != null) ? ViewData["file_text"].ToString() : Model.inputText;
         %>
         <input type="hidden" id="outputText" value="<%: _output_text  %>" />
            <script type="text/javascript" language="javascript">
            <!--
                jQuery(document).ready(function ($) {
                    load_words_report($("#outputText"));
                });
            //-->
            </script>
         <% 
           }else{
                _display = "none";
           } 
        %>
        <div id="form_output" style="display:<%: _display %>;">
            <hr/>
            <div style="text-align: left">
                <h3>Scan results</h3>
            </div>
            <div style="text-align: center; width: 90%;  display: block;">
                        <div style="text-align: center;">
                            <div style="width: 50%;text-align: left; display:inline-block; height: 75px;">
                                <div class="form_line"><%: Html.LabelFor(m => m.totalPriceUsingLines)%></div>
                                <div class="form_line"><%: Html.LabelFor(m => m.totalPriceUsingLinesByCRLF)%>&nbsp;&nbsp;</div>                        
                                <div class="form_line"><%: Html.LabelFor(m => m.totalPriceUsingWords)%>&nbsp;&nbsp;</div>
                                <div class="form_line"><%: Html.LabelFor(m => m.countedLines)%>&nbsp;&nbsp;</div>
                                <div class="form_line"><%: Html.LabelFor(m => m.countedLinesByCRLF)%>&nbsp;&nbsp;</div>
                                <div class="form_line"><%: Html.LabelFor(m => m.countedWords)%>&nbsp;&nbsp;</div>
                            </div>
                            <div style="width: 40%;text-align: right; display:inline-block; height: 75px;">
                                <div class="form_line"><span class="form_output_item" id="totalPriceUsingLines"><%: Model.totalPriceUsingLines %> &euro;</span></div>
                                <div class="form_line"><span class="form_output_item" id="totalPriceUsingLinesByCRLF"><%: Model.totalPriceUsingLinesByCRLF %> &euro;</span></div>
                                <div class="form_line"><span class="form_output_item" id="totalPriceUsingWords"><%: Model.totalPriceUsingWords %> &euro;</span></div>
                                <div class="form_line"><span class="form_output_item" id="countedLines"><%: Model.countedLines %></span></div>
                                <div class="form_line"><span class="form_output_item" id="countedLinesByCRLF"><%: Model.countedLinesByCRLF %></span></div>
                                <div class="form_line"><span class="form_output_item" id="countedWords"><%: Model.countedWords %></span></div>
                            </div>
                        </div>
            </div>
            <div>
                &nbsp;
            </div>
        
        </div>
        <hr/>
        <div id="repetitions_container" >
			
			<div style="text-align: left; width: 100%;"><h3>Repeated words review</h3></div>
			<div id="word_list"></div>
			<div id="output_text"></div>
			<hr/>
		</div>
            </div>            
            <% } %>
        </div>
    </asp:Content>