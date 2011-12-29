jQuery(document).ready(function ($) {
    $("#myform").submit(function (event) {
        dump_text($("#inputText"), $("#output_text"));
        build_word_list($("#inputText"), $("#word_list"));
        $("#repetitions_container").show();
        return false;
    });

    function dump_text(from, to) {
        var text = from.val().trim();
        text = text.replace(/\n/g, "</p><p>");
        to.html("<p>" + text + "</p>");
    }

    function build_word_list(from, item) {
        var wordlist = list_repeated_words(from.val());
        var html_text = "";
        for (var i = 0; i < wordlist.length; i++) {
            html_text += " <span class=\"word\">" + wordlist[i] + "</span>";
        }
        item.html(html_text);

        $("span.word").click(function (event) {
            var text = $(this).text();
            $("#output_text").removeHighlight();
            $("#output_text").highlight(text);

        });
    }

    function list_repeated_words(text) {
        var sortedWords = text.split(/\b(\w+)\b/g);
        sortedWords.sort();
        duplicateWords = [];
        for (var i = 0; i < sortedWords.length - 1; i++) {
            if (sortedWords[i + 1] == sortedWords[i]) {
                duplicateWords.push(sortedWords[i]);
            }
        }
        return $.unique(duplicateWords.sort());
    }

});