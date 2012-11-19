--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
module Hakyll.Web.Template.Tests
    ( tests
    ) where


--------------------------------------------------------------------------------
import           Test.Framework                 (Test, testGroup)
import           Test.Framework.Providers.HUnit (testCase)
import           Test.HUnit                     (Assertion, (@=?))


--------------------------------------------------------------------------------
import           Hakyll.Core.Item
import           Hakyll.Core.Provider
import           Hakyll.Web.Page
import           Hakyll.Web.Template
import           Hakyll.Web.Template.Context
import           TestSuite.Util


--------------------------------------------------------------------------------
tests :: Test
tests = testGroup "Hakyll.Core.Template.Tests"
    [ testCase "case01" case01
    ]


--------------------------------------------------------------------------------
case01 :: Assertion
case01 = withTestStore $ \store -> do
    provider <- newTestProvider store

    out  <- resourceString provider "example.md.out"
    tpl  <- testCompilerDone store provider "template.html" $ templateCompiler
    item <- testCompilerDone store provider "example.md"    $
        pageCompiler >>= applyTemplate (itemBody tpl) defaultContext

    out @=? itemBody item
