#!/usr/bin/env python2

"""
Pandoc filter to convert admonitions to divs
"""

from pandocfilters import toJSONFilters, Para, Div, RawBlock

def admonitions(key, value, format, meta):
    
    if key == 'Para' and value[0]['c'] == '!!!':
        #print(value)
        new_values = value
        
        del new_values[0]
        del new_values[0]
        del new_values[0]
        del new_values[0]
        print(new_values)

        # Div([ident, classes, kvs], newcontents)
        #return Div(['adm', ['admonition'], []], [RawBlock('html', '<em>test</em>')])
        return Para(new_values)

def main():
    toJSONFilters([admonitions])

if __name__ == '__main__':
    main()
