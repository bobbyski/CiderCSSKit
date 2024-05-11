//
//  CSSComplexTests.swift
//  
//
//  Created by Bobby Skinner on 5/8/24.
//

import XCTest
@testable import CiderCSSKit

final class CSSComplexTests: XCTestCase {
    
    let mediumString =  """
                        
                            body {
                                font-family: Arial, sans-serif;
                            }
                            h1 {
                                color: blue;
                                text-align: center; /* Center the text */
                            }
                            b { /* Selects all bold text */
                                color: red;
                            }
                        
                        """
    
    let googleCSS = """
                    /* Copyright 2015 The Chromium Authors
                     * Use of this source code is governed by a BSD-style license that can be
                     * found in the LICENSE file. */

                    /* This file is dynamically processed by a C++ data source handler to fill in
                     * some per-platform/locale styles that dramatically alter the page. This is
                     * done to reduce flicker, as JS may not run before the page is rendered.
                     *
                     * There are two ways to include this stylesheet:
                     * 1. via its chrome://resources/ URL in HTML, i.e.:
                     *
                     *   <link rel="stylesheet" href="chrome://resources/css/text_defaults_md.css">
                     *
                     * 2. via the webui::AppendWebUICSSTextDefaultsMd() method to directly append it
                     * to an HTML string.
                     * Otherwise its placeholders won't be expanded. */

                    body {
                      font-family: system-ui, sans-serif;
                      font-size: 81.25%;
                    }

                    button {
                      font-family: system-ui, sans-serif;
                    }
                    """

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMedium() throws 
    {
        do
        {
            let rules = try CSSParser.parse(buffer: mediumString )
            
            XCTAssert( rules.count == 3, "There should be 3 rules")
        }
        catch
        {
            XCTAssert( false, "Exception: \(error)")
        }
    }
    
    func testTokenMedium() throws
    {
        do
        {
            let tokens = try CSSTokenizer.tokenize(buffer: mediumString)
            
            XCTAssert( tokens.count == 51, "There should be 51 tokens")
        }
        catch
        {
            XCTAssert( false, "Exception: \(error)")
        }
    }
    
    func testGoogle() throws
    {
        do
        {
            let rules = try CSSParser.parse(buffer: googleCSS )
            
            XCTAssert( rules.count == 2, "There should be 2 rules")
        }
        catch
        {
            XCTAssert( false, "Exception: \(error)")
        }
    }


}
