using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SQLSaturday
{
    class Program
    {
        static void Main(string[] args)
        {
            var options = new Options();
            if (CommandLine.Parser.Default.ParseArguments(args, options))
            {
                List<int> eventRange = rangeParser.ParseRange(options.Range);                
                Console.WriteLine(string.Format("Retrieving events {0} to {1}", eventRange.Min(), eventRange.Max()));
                var p = new Processor(options);
                p.ConnectionValid();
                if (options.Operation.ToUpper() == "DROP") { p.CreateObjects();  }
                p.LoadData(eventRange);


                Console.WriteLine("Press Any Key");
                Console.ReadKey();


            }
        }
    }
}
