/*
 * jquery-counter plugin
 *
 * Copyright (c) 2009 Martin Conte Mac Donell <Reflejo@gmail.com>
 * Dual licensed under the MIT and GPL licenses.
 * http://docs.jquery.com/License
 */
countdown = function(userOptions)
{
	var h,m,s,t;
	var init = function()
	{
		userOptions.time = userOptions.time*60 - userOptions.lefttime;
		s = userOptions.time%60;
		m = parseInt(userOptions.time%3600/60);
		h = parseInt(userOptions.time/3600);
	}

	var setval = function()
	{
		if(s >= 10)
		userOptions.sbox.html(s);
		else
		userOptions.sbox.html('0'+s.toString());
		if(m >= 10)
		userOptions.mbox.html(m);
		else
		userOptions.mbox.html('0'+ m);
		if(h >= 10)
		userOptions.hbox.html(h);
		else
		userOptions.hbox.html('0'+ h);
	}

	var step = function()
	{
		if(s > 0)
		{
			s--;
		}
		else
		{
			if(m > 0)
			{
				m--;
				s = 60;
				s--;
			}
			else
			{
				if(h > 0)
				{
					h--;
					m = 60;
					m--;
					s = 60;
					s--;
				}
				else
				{
					clearInterval(interval);
					userOptions.finish();
					return ;
				}
			}
		}
		setval();
	}
	init();
	interval = setInterval(step, 1000);
};