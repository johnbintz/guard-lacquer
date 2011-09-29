Using [Varnish](https://www.varnish-cache.org/) with your app? Want to test your caching goodness locally first? Don't want to deal with
craaaazy global VCLs or manually restarting things? `guard-lacquer` is what you want!

It wraps up the server running parts of Lacquer, abstracts out their Rails-isms, and starts and stops them just like any other Guard!
If you don't have a `config/config.vcl.erb` file in your app for use with Lacquer, it copies that over for you, too.


