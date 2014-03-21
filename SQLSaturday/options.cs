using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CommandLine;
using CommandLine.Text;

namespace SQLSaturday
{
    class Options
    {
        [Option('s', "server", 
            Required = true,
            HelpText = "Database Server")]
        public string Server { get; set; }

        [Option('d', "database",
            Required = true,
            HelpText = "Name of Database")]
        public string Database { get; set; }

        [Option('u', "u",
            Required = false,
            HelpText = "Database User Name")]
        public string UserName  { get; set; }

        [Option('p', "pasword",
            Required = false ,
            HelpText = "Database Password")]
        public string password { get; set; }

        
        [Option('r', "range",
                DefaultValue = "1-10000",
                Required = false,
                HelpText = "Provide a range of events to download")]
        public string Range { get; set; }

        [Option('o', "operation",
                DefaultValue = "Drop",
                Required = false,
                HelpText = @"Operation to perform: 
                    Drop - Drops all Objects and Recreates them, Importing Everything Fresh
                    Refresh - Refreshes Data wihtout Modifying ")]
        public string Operation { get; set; }
  
        [ParserState]
        public IParserState LastParserState { get; set; }

        [HelpOption]
        public string GetUsage()
        {
            return HelpText.AutoBuild(this, (HelpText current) => HelpText.DefaultParsingErrorsHandler(this, current));
        }
    }
}
