using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using System.Text.RegularExpressions;

namespace analyzr.Models
{
    public class CounterModel
    {
        [DisplayName("Text to scan")]
        public string inputText { get; set; }

        [Required]
        [DisplayName("Price per word")]
        [DefaultValue(1.0)]
        public Double pricePerWord { get; set; }

        [Required]
        [DisplayName("Price per line")]
        [DefaultValue(10.0)]
        public Double pricePerLine { get; set; }

        [Required]
        [DisplayName("Line lenght in chars")]
        [DefaultValue(80)]
        public int charsPerLine { get; set; }

        
        [DisplayName("Total lines by line length")]
        [DefaultValue(0)]
        public int countedLines { get; set; }

        [DisplayName("Total repeated words (found more than once in the text)")]
        [DefaultValue(0)]
        public int countedRepeatedWords { get; set; }

        [DisplayName("Total lines by line returns")]
        [DefaultValue(0)]
        public int countedLinesByCRLF { get; set; }


        [DisplayName("Total words")]
        [DefaultValue(0)]
        public int countedWords { get; set; }

        [DisplayName("Total price using words")]
        [DefaultValue(0.0)]
        public Double totalPriceUsingWords { get; set; }

        
        [DisplayName("Total price using lines by line length")]
        [DefaultValue(0.0)]
        public Double totalPriceUsingLines { get; set; }

        [DisplayName("Total price using lines by line returns")]
        [DefaultValue(0.0)]
        public Double totalPriceUsingLinesByCRLF { get; set; }


        public bool getRepeatedWords() {
            try
            {
                MatchCollection collection = Regex.Matches(this.inputText, @"\b(?<word>\w+)\s+(\k<word>)\b");
                this.countedRepeatedWords = collection.Count;
            }
            catch (Exception)
            {
                this.countedRepeatedWords = -1;
                return false;
            }


            return true;
        }


        public bool getLinesByLength() {
            try
            {
                int textLength = this.inputText.Length;
                int charsPerLine = this.charsPerLine;
                this.countedLines = int.Parse(Math.Ceiling(
                                                Double.Parse(textLength.ToString()) / Double.Parse(charsPerLine.ToString())
                                                ).ToString());

            }
            catch (Exception) {
                this.countedLines = -1;
                return false;
            }
            return true;
        }

        public bool getLinesByCrLf() {
            try {
                MatchCollection collection = Regex.Matches(this.inputText, "\n");
                this.countedLinesByCRLF = collection.Count;
            } catch (Exception) {
                this.countedLinesByCRLF = -1;
                return false;
            }
            return true;
        }

        public bool getWords()
        {
            try
            {
                MatchCollection collection = Regex.Matches(this.inputText, @"[\S]+");
	            this.countedWords = collection.Count;
            }
            catch (Exception)
            {
                this.countedWords = -1;
                return false;
            }
            return true;
        }

        public bool getPrices() {
            try
            {
                string[] lines;
                lines = System.Text.RegularExpressions.Regex.Split(this.inputText, "\n", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
                this.countedLinesByCRLF = lines.Length;

                this.totalPriceUsingLines = this.countedLines * this.pricePerLine;
                this.totalPriceUsingLinesByCRLF = this.countedLinesByCRLF * this.pricePerLine;
                this.totalPriceUsingWords = this.countedWords * this.pricePerWord;
            }
            catch (Exception)
            {
                this.totalPriceUsingLines = -1;
                this.totalPriceUsingLinesByCRLF = -1;
                this.totalPriceUsingWords = -1;
                return false;
            }
            return true;
        }

        public bool doMaths() {
            try
            {
                getWords();
                getLinesByCrLf();
                getLinesByLength();
                getPrices();
                getRepeatedWords();
            } catch (Exception) {
                this.totalPriceUsingLines = 0;
                this.totalPriceUsingLinesByCRLF = 0;
                this.totalPriceUsingWords = 0;
                this.countedLines = 0;
                this.countedLinesByCRLF = 0;
                this.countedWords = 0;
                this.countedRepeatedWords = 0;
                return false;
            }
            return true;
        }


    }
}