jQuery(document).ready(function ($) {
    $("#forminput").submit(function () {
        return false;
    });


    $("#submit_button").click(function () {
        var validation_status = validate_input();
        if (validation_status != "OK") {
            alert(validation_status);
            return false;
        }
        var input_text = $("#inputText").val();
        var price_per_word = $("#pricePerWord").val();
        var price_per_line = $("#pricePerLine").val();
        var chars_per_line = $("#charsPerLine").val();
        $.ajax({
            type: 'POST',
            url: '/home/counter_backend',
            data: {
                'inputText': input_text,
                'pricePerWord': price_per_word,
                'pricePerLine': price_per_line,
                'charsPerLine': chars_per_line
            },
            success: function (data, textStatus, jqXHR) {
                $("#totalPriceUsingLines").text(data.totalPriceUsingLines);
                $("#totalPriceUsingLinesByCRLF").text(data.totalPriceUsingLinesByCRLF);
                $("#totalPriceUsingWords").text(data.totalPriceUsingWords);
                $("#countedLines").text(data.countedLines);
                $("#countedLinesByCRLF").text(data.countedLinesByCRLF);
                $("#countedWords").text(data.countedWords);
                $("#countedRepeatedWords").text(data.countedRepeatedWords);
                $("#form_output").show();
                dump_text($("#inputText"), $("#output_text"));
                build_word_list($("#inputText"), $("#word_list"));
                $("#repetitions_container").show();
            },
            dataType: 'json'
        });
        return false;
    });

    function dump_text(from, to) {
        var text = from.val().trim();
        text = text.replace(/\n/g, "</p><p class=\"translate_paragraph\">");
        to.html("<p class=\"translate_paragraph\">" + text + "</p>");
    }

    function build_word_list(from, item) {
        var wordlist = list_repeated_words(from.val());
        var html_text = "";
        for (var i = 0; i < wordlist.length; i++) {
            html_text += " <span class=\"word\">" + wordlist[i] + "&nbsp;<span class=\"repetition_count\">(" + count_reps_for(wordlist[i], from.val()) + ")</span></span>";
        }
        item.html(html_text);

        $("span.word").click(function (event) {
            var text = $(this).html().split("&nbsp;");
            $("#output_text").removeHighlight();
            $("#output_text").highlight(text[0]);

        });
    }

    function count_reps_for(word, in_text) {
        return in_text.match(new RegExp("\\b" + word + "\\b", "g")).length;
    }

    function list_repeated_words(text) {
        var sortedWords = text.split(/\b(\w+)\b/g);
        sortedWords.sort();
        duplicateWords = [];
        for (var i = 0; i < sortedWords.length - 1; i++) {
            if (sortedWords[i + 1] == sortedWords[i]) {
                if (sortedWords[i].match(/\w/))
                    duplicateWords.push(sortedWords[i]);
            }
        }
        return $.unique(duplicateWords.sort()).sort();
    }

    function validate_input() {
        var input_text = $("#inputText").val();
        var price_per_word = $("#pricePerWord").val();
        var price_per_line = $("#pricePerLine").val();
        var chars_per_line = $("#charsPerLine").val();
        if ($.trim(input_text) == "") return "Input text must not be empty";
        if (!price_per_word.match(/^[-+]?\b[0-9]*\.?[0-9]+\b$/)) return "Price per word must be an integer or currency number";
        if (!price_per_line.match(/^[-+]?\b[0-9]*\.?[0-9]+\b$/)) return "Price per line must be an integer or currency number";
        if (!chars_per_line.match(/\b\d+\b/)) return "Characters per line must be an integer number";
        return "OK";
    }

});