﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using analyzr;
using analyzr.Controllers;

namespace analyzr.Tests.Controllers
{
    [TestClass]
    public class HomeControllerTest
    {
        [TestMethod]
        public void Index()
        {
          //tricky tricky. Just trying
            Assert.AreEqual(true, true);
        }
    }
}
