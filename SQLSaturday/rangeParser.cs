using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SQLSaturday
{
    public static class rangeParser
    {

     
        public static List<int> ParseRange (string range) {
            var list = new List<int>();

            foreach( string s in range.Split(',') ) 
            {
                // try and get the number
                int num;
                if( int.TryParse( s, out num ) )
                {

                    list.Add(num);
                    continue; // skip the rest
                }

                // otherwise we might have a range
                // split on the range delimiter
                string[] subs = s.Split('-');
                int start, end;

                // now see if we can parse a start and end
                if( subs.Length > 1 &&
                    int.TryParse(subs[0], out start) &&
                    int.TryParse(subs[1], out end) &&
                    end >= start) 
                {
                    // create a range between the two values
                    int rangeLength = end - start + 1;
                    foreach(int i in Enumerable.Range(start, rangeLength))
                    {
                        list.Add(i);
                    }
                }
                ;
            }
            list.Sort();            
            return list;
        }
    }
}
