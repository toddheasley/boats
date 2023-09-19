import XCTest
@testable import Boats

class ScheduleTests: XCTestCase {
    func testIsExpired() {
        XCTAssertEqual(Schedule(season: Season(.spring, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1523678400.0), end: Date(timeIntervalSince1970: 1529121599.9))), timetables: []).isExpired, Date() > Date(timeIntervalSince1970: 1529121599.9))
        XCTAssertEqual(Schedule(season: Season(.winter, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1539057600), end: Date(timeIntervalSince1970: 1546664399.9))), timetables: []).isExpired, Date() > Date(timeIntervalSince1970: 1546664399.9))
    }
    
    func testTimetable() {
        let schedule: Schedule = Schedule(season: Season(.summer, dateInterval: DateInterval(start: Date(timeIntervalSince1970: 1529121600.0), end: Date(timeIntervalSince1970: 1536033599.9))), timetables: [
            Timetable(trips: [Timetable.Trip()], days: [.monday, .tuesday, .wednesday, .thursday]),
            Timetable(trips: [Timetable.Trip(), Timetable.Trip()], days: [.friday, .saturday])
        ])
        XCTAssertEqual(schedule.timetable(for: .saturday)?.trips.count, 2)
        XCTAssertEqual(schedule.timetable(for: .tuesday)?.trips.count, 1)
    }
}

extension ScheduleTests {
    
    // MARK: HTMLConvertible
    func testHTMLInit() {
        guard let html: String = String(data: HTML_Data, encoding: .utf8), !html.isEmpty else {
            XCTFail()
            return
        }
        XCTAssertEqual(try? Schedule(from: html).season.name, .winter)
        XCTAssertEqual(try? Schedule(from: html).timetables.count, 4)
    }
}

private let HTML_Data: Data = """
<!DOCTYPE html>
<html lang="en-US" prefix="og: http://ogp.me/ns#" class="no-js">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="format-detection" content="telephone=no">
<link rel="profile" href="http://gmpg.org/xfn/11">
<link rel="pingback" href="https://www.cascobaylines.com/xmlrpc.php">

<title>Peaks Island Ferry Sailing Schedule for Winter - Portland, Maine</title>

<!-- This site is optimized with the Yoast SEO plugin v9.0.3 - https://yoast.com/wordpress/plugins/seo/ -->
<meta name="description" content="Peaks Island ferry sailing schedule for Winter shows departure times between Portland and Casco Bay Islands."/>
<link rel="canonical" href="https://www.cascobaylines.com/schedules/peaks-island-schedule/winter/" />
<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="Peaks Island Ferry Sailing Schedule for Winter - Portland, Maine" />
<meta property="og:description" content="Peaks Island ferry sailing schedule for Winter shows departure times between Portland and Casco Bay Islands." />
<meta property="og:url" content="https://www.cascobaylines.com/schedules/peaks-island-schedule/winter/" />
<meta property="og:site_name" content="Casco Bay Lines" />
<meta property="article:publisher" content="http://facebook.com/cascobaylines/" />
<!-- / Yoast SEO plugin. -->

<link rel='dns-prefetch' href='//fonts.googleapis.com' />
<link rel='dns-prefetch' href='//s.w.org' />
<link rel="alternate" type="application/rss+xml" title="Casco Bay Lines &raquo; Feed" href="https://www.cascobaylines.com/feed/" />
<link rel="alternate" type="application/rss+xml" title="Casco Bay Lines &raquo; Comments Feed" href="https://www.cascobaylines.com/comments/feed/" />
<link rel='stylesheet' id='cascobaylines-stylesheet-css'  href='https://www.cascobaylines.com/wp-content/themes/cascobaylines/css/style.css?ver=20180821' type='text/css' media='all' />
<link rel='stylesheet' id='cascobaylines-google-fonts-css'  href='//fonts.googleapis.com/css?family=Just+Another+Hand%7CRoboto%3A400%2C400i%2C700%2C700i&#038;ver=4.9.8' type='text/css' media='all' />
<link rel='stylesheet' id='cascobaylines-font-awesome-css'  href='https://www.cascobaylines.com/wp-content/themes/cascobaylines/libs/font-awesome/css/fontawesome-all.min.css?ver=5.0.1.3' type='text/css' media='all' />
<script type='text/javascript' src='https://www.cascobaylines.com/wp-content/themes/cascobaylines/libs/js/custom-modernizr.min.js?ver=3.6.0'></script>
<script type='text/javascript' src='https://www.cascobaylines.com/wp-includes/js/jquery/jquery.js?ver=1.12.4'></script>
<script type='text/javascript' src='https://www.cascobaylines.com/wp-includes/js/jquery/jquery-migrate.min.js?ver=1.4.1'></script>
<link rel='https://api.w.org/' href='https://www.cascobaylines.com/wp-json/' />
<link rel='shortlink' href='https://www.cascobaylines.com/?p=183' />
<link rel="alternate" type="application/json+oembed" href="https://www.cascobaylines.com/wp-json/oembed/1.0/embed?url=https%3A%2F%2Fwww.cascobaylines.com%2Fschedules%2Fpeaks-island-schedule%2Fwinter%2F" />
<link rel="alternate" type="text/xml+oembed" href="https://www.cascobaylines.com/wp-json/oembed/1.0/embed?url=https%3A%2F%2Fwww.cascobaylines.com%2Fschedules%2Fpeaks-island-schedule%2Fwinter%2F&#038;format=xml" />
<!-- Stream WordPress user activity plugin v3.2.3 -->

<!-- Dynamic Widgets by QURL loaded - http://www.dynamic-widgets.com //-->
<style type="text/css">#banner { display: block; background-image: url(/wp-content/themes/cascobaylines/images/page-headers/peaks-island.jpg); }</style>
        <style type="text/css" media="screen"></style><link rel="icon" href="https://www.cascobaylines.com/uploads/cropped-cbl-site-icon-32x32.png" sizes="32x32" />
<link rel="icon" href="https://www.cascobaylines.com/uploads/cropped-cbl-site-icon-192x192.png" sizes="192x192" />
<link rel="apple-touch-icon-precomposed" href="https://www.cascobaylines.com/uploads/cropped-cbl-site-icon-180x180.png" />
<meta name="msapplication-TileImage" content="https://www.cascobaylines.com/uploads/cropped-cbl-site-icon-270x270.png" />



<script type="text/javascript">
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-2721489-1']);
    var pluginUrl = '//www.google-analytics.com/plugins/ga/inpage_linkid.js';
    _gaq.push(['_require', 'inpage_linkid', pluginUrl]);
</script>

<script type="text/javascript">
  if (typeof AlternateTrackPageview == "undefined") {
      _gaq.push(['_trackPageview']);
  } else {
      _gaq.push(['_trackPageview', AlternateTrackPageview]);
  }
  (function () {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>
<script src="https://hwscdn.com/analytics/cascobaylines.com/main_analytics.js"></script>

    
<!-- Hotjar Tracking Code for https://www.cascobaylines.com/ -->
<script>
    (function(h,o,t,j,a,r){
        h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)};
        h._hjSettings={hjid:754789,hjsv:6};
        a=o.getElementsByTagName('head')[0];
        r=o.createElement('script');r.async=1;
        r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv;
        a.appendChild(r);
    })(window,document,'https://static.hotjar.com/c/hotjar-','.js?sv=');
</script>

</head>

<body class="page-template-default page page-id-183 page-child parent-pageid-639">

    <div id="container">
        
        <a class="skip-link screen-reader-text" href="#content">Skip to content</a>

        <header id="masthead" class="header" role="banner">
            
                        
                        
            
            <div id="inner-header" class="container-fluid no-padding">
                
                <div class="header-row row no-gutters">

                    <div id="logo">
                        <a href="https://www.cascobaylines.com/" rel="home" title="Casco Bay Lines">
                            <img src="https://www.cascobaylines.com/wp-content/themes/cascobaylines/images/cbl-logo.svg" alt="Casco Bay Lines">
                        </a>
                    </div>
                    
                    <div id="mobile-menu-toggle">
                        <button id="mobile-menu-button" type="button">Menu</button>
                        <a class="phone" href="tel:+1-207-774-7871">207.774.7871</a>
                    </div>
                    
                    <nav id="main-navigation" role="navigation" aria-label="Primary Navigation">
                        <ul id="menu-main-menu" class="menu main-menu"><li class="menu-item phone-item"><span class="phone">207.774.7871</span></li><li id="menu-item-47" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children"><a title="Islands" href="https://www.cascobaylines.com/islands/">Islands</a><button class="menu-button" type="button"><i class="fa fa-chevron-right"></i></button>
<ul class="sub-menu menu-odd menu-depth-1"><li class="menu-back-item"><button class="menu-back-button" type="button"><i class="fa fa-chevron-left"></i> Back</button></li>
    <li id="menu-item-563" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Peaks Island" href="https://www.cascobaylines.com/islands/peaks-island-maine/">Peaks Island</a></li>
    <li id="menu-item-561" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Little Diamond Island" href="https://www.cascobaylines.com/islands/little-diamond-island-maine/">Little Diamond Island</a></li>
    <li id="menu-item-560" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Great Diamond Island" href="https://www.cascobaylines.com/islands/great-diamond-island-maine/">Great Diamond Island</a></li>
    <li id="menu-item-559" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Diamond Cove" href="https://www.cascobaylines.com/islands/diamond-cove-maine/">Diamond Cove</a></li>
    <li id="menu-item-562" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Long Island" href="https://www.cascobaylines.com/islands/long-island-maine/">Long Island</a></li>
    <li id="menu-item-557" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Chebeague Island" href="https://www.cascobaylines.com/islands/chebeague-island-maine/">Chebeague Island</a></li>
    <li id="menu-item-558" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Cliff Island" href="https://www.cascobaylines.com/islands/cliff-island-maine/">Cliff Island</a></li>
    <li id="menu-item-556" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Bailey Island" href="https://www.cascobaylines.com/islands/bailey-island-maine/">Bailey Island</a></li>
</ul>
</li>
<li id="menu-item-46" class="menu-item menu-item-type-post_type menu-item-object-page current-page-ancestor menu-item-has-children"><a title="Schedules" href="https://www.cascobaylines.com/schedules/">Schedules</a><button class="menu-button" type="button"><i class="fa fa-chevron-right"></i></button>
<ul class="sub-menu menu-odd menu-depth-1"><li class="menu-back-item"><button class="menu-back-button" type="button"><i class="fa fa-chevron-left"></i> Back</button></li>
    <li id="menu-item-842" class="menu-item menu-item-type-post_type menu-item-object-page current-page-ancestor menu-item-no-children"><a title="Peaks Island Schedule" href="https://www.cascobaylines.com/schedules/peaks-island-schedule/">Peaks Island Schedule</a></li>
    <li id="menu-item-847" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Little Diamond Island Schedule" href="https://www.cascobaylines.com/schedules/little-diamond-island-schedule/">Little Diamond Island Schedule</a></li>
    <li id="menu-item-846" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Great Diamond Island Schedule" href="https://www.cascobaylines.com/schedules/great-diamond-schedule/">Great Diamond Island Schedule</a></li>
    <li id="menu-item-845" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Diamond Cove Schedule" href="https://www.cascobaylines.com/schedules/diamond-cove-schedule/">Diamond Cove Schedule</a></li>
    <li id="menu-item-841" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Long Island Schedule" href="https://www.cascobaylines.com/schedules/long-island-schedule/">Long Island Schedule</a></li>
    <li id="menu-item-843" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Chebeague Island Schedule" href="https://www.cascobaylines.com/schedules/chebeague-island-schedule/">Chebeague Island Schedule</a></li>
    <li id="menu-item-844" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Cliff Island Schedule" href="https://www.cascobaylines.com/schedules/cliff-island-schedule/">Cliff Island Schedule</a></li>
    <li id="menu-item-1701" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Bailey Island Schedule" href="https://www.cascobaylines.com/schedules/bailey-island-schedule/">Bailey Island Schedule</a></li>
    <li id="menu-item-1619" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Scenic Cruises" href="https://www.cascobaylines.com/maine-boat-tours/specialty-cruises/">Specialty Cruises</a></li>
</ul>
</li>
<li id="menu-item-45" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children"><a title="Rates" href="https://www.cascobaylines.com/portland-ferry-rates/">Rates</a><button class="menu-button" type="button"><i class="fa fa-chevron-right"></i></button>
<ul class="sub-menu menu-odd menu-depth-1"><li class="menu-back-item"><button class="menu-back-button" type="button"><i class="fa fa-chevron-left"></i> Back</button></li>
    <li id="menu-item-570" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Ferry Passenger Fares" href="https://www.cascobaylines.com/portland-ferry-rates/passenger/">Ferry Passenger Fares</a></li>
    <li id="menu-item-1175" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Vehicle Rates to Peaks Island" href="https://www.cascobaylines.com/portland-ferry-rates/peaks-island-car-ferry/">Vehicle Rates to Peaks Island</a></li>
    <li id="menu-item-1174" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Vehicle Rates Downbay" href="https://www.cascobaylines.com/portland-ferry-rates/island-car-ferry/">Vehicle Rates Downbay</a></li>
    <li id="menu-item-571" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Freight Info" href="https://www.cascobaylines.com/portland-ferry-rates/island-freight-info/">Freight Info</a></li>
    <li id="menu-item-572" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Freight Rates" href="https://www.cascobaylines.com/portland-ferry-rates/island-freight/">Freight Rates</a></li>
</ul>
</li>
<li id="menu-item-43" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children"><a title="Cruises &#038; Tours" href="https://www.cascobaylines.com/maine-boat-tours/">Cruises &#038; Tours</a><button class="menu-button" type="button"><i class="fa fa-chevron-right"></i></button>
<ul class="sub-menu menu-odd menu-depth-1"><li class="menu-back-item"><button class="menu-back-button" type="button"><i class="fa fa-chevron-left"></i> Back</button></li>
    <li id="menu-item-1133" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children"><a title="Scenic Cruises" href="https://www.cascobaylines.com/maine-boat-tours/specialty-cruises/">Specialty Cruises</a><button class="menu-button" type="button"><i class="fa fa-chevron-right"></i></button>
    <ul class="sub-menu menu-even menu-depth-2"><li class="menu-back-item"><button class="menu-back-button" type="button"><i class="fa fa-chevron-left"></i> Back</button></li>
        <li id="menu-item-576" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Mailboat Run" href="https://www.cascobaylines.com/maine-boat-tours/specialty-cruises/mailboat/">Mailboat Run</a></li>
        <li id="menu-item-904" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Sunrise on the Bay" href="https://www.cascobaylines.com/maine-boat-tours/specialty-cruises/sunrise/">Sunrise Run</a></li>
        <li id="menu-item-905" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Sunset Run" href="https://www.cascobaylines.com/maine-boat-tours/specialty-cruises/sunset/">Sunset Run</a></li>
        <li id="menu-item-1207" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Moonlight Run" href="https://www.cascobaylines.com/maine-boat-tours/specialty-cruises/moonlight/">Moonlight Run</a></li>
        <li id="menu-item-1365" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Diamond Pass Run" href="https://www.cascobaylines.com/maine-boat-tours/specialty-cruises/diamond-pass/">Diamond Pass Run</a></li>
        <li id="menu-item-573" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Bailey Island Cruise" href="https://www.cascobaylines.com/maine-boat-tours/specialty-cruises/bailey-island/">Bailey Island Cruise</a></li>
    </ul>
</li>
    <li id="menu-item-574" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Music Cruises" href="https://www.cascobaylines.com/maine-boat-tours/music-cruises/">Music Cruises</a></li>
    <li id="menu-item-906" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Special Event Cruises" href="https://www.cascobaylines.com/maine-boat-tours/special-event-holiday-cruises/">Special Event Cruises</a></li>
</ul>
</li>
<li id="menu-item-42" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children"><a title="Groups &#038; Charters" href="https://www.cascobaylines.com/maine-boat-charters-groups/">Groups &#038; Charters</a><button class="menu-button" type="button"><i class="fa fa-chevron-right"></i></button>
<ul class="sub-menu menu-odd menu-depth-1"><li class="menu-back-item"><button class="menu-back-button" type="button"><i class="fa fa-chevron-left"></i> Back</button></li>
    <li id="menu-item-2114" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Private Charters" href="https://www.cascobaylines.com/maine-boat-charters-groups/private-charters/">Private Charters</a></li>
    <li id="menu-item-2113" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Group Tours" href="https://www.cascobaylines.com/maine-boat-charters-groups/group-tours/">Group Tours</a></li>
    <li id="menu-item-580" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Lobster Bakes" href="https://www.cascobaylines.com/maine-boat-charters-groups/maine-lobster-bakes/">Lobster Bakes</a></li>
    <li id="menu-item-1025" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Weddings" href="https://www.cascobaylines.com/maine-boat-charters-groups/maine-wedding-cruises/">Weddings</a></li>
    <li id="menu-item-579" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Entertainer Listing" href="https://www.cascobaylines.com/maine-boat-charters-groups/entertainers/">Entertainer Listing</a></li>
    <li id="menu-item-578" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Caterer Listing" href="https://www.cascobaylines.com/maine-boat-charters-groups/caterers/">Caterer Listing</a></li>
</ul>
</li>
<li id="menu-item-4183" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children"><a title="About Us" href="https://www.cascobaylines.com/about-us/">About Us</a><button class="menu-button" type="button"><i class="fa fa-chevron-right"></i></button>
<ul class="sub-menu menu-odd menu-depth-1"><li class="menu-back-item"><button class="menu-back-button" type="button"><i class="fa fa-chevron-left"></i> Back</button></li>
    <li id="menu-item-4189" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Contact Us" href="https://www.cascobaylines.com/contact-us/">Contact Us</a></li>
    <li id="menu-item-4185" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Commuter Center" href="https://www.cascobaylines.com/about-us/commuter-center/">Commuter Center</a></li>
    <li id="menu-item-4186" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Getting Here" href="https://www.cascobaylines.com/about-us/parking-and-directions/">Getting Here</a></li>
    <li id="menu-item-4188" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Blog" href="https://www.cascobaylines.com/blog/">Blog</a></li>
    <li id="menu-item-4190" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="News" href="https://www.cascobaylines.com/ferry-news/">News</a></li>
    <li id="menu-item-4191" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children"><a title="Board of Directors" href="https://www.cascobaylines.com/about-us/board/">Board of Directors</a><button class="menu-button" type="button"><i class="fa fa-chevron-right"></i></button>
    <ul class="sub-menu menu-even menu-depth-2"><li class="menu-back-item"><button class="menu-back-button" type="button"><i class="fa fa-chevron-left"></i> Back</button></li>
        <li id="menu-item-4620" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="CBITD Board Committees 2017-2018" href="https://www.cascobaylines.com/about-us/board/committee-list/">CBITD Board Committees 2017-2018</a></li>
    </ul>
</li>
    <li id="menu-item-4184" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Career Opportunities" href="https://www.cascobaylines.com/about-us/career/">Career Opportunities</a></li>
    <li id="menu-item-4187" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="History" href="https://www.cascobaylines.com/about-us/history/">History</a></li>
    <li id="menu-item-4192" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Important Links" href="https://www.cascobaylines.com/about-us/important-links/">Important Links</a></li>
    <li id="menu-item-4193" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Video Directory" href="https://www.cascobaylines.com/about-us/video-directory/">Video Directory</a></li>
    <li id="menu-item-4621" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Staff Directory" href="https://www.cascobaylines.com/about-us/staff-crew/">Staff Directory</a></li>
    <li id="menu-item-4622" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Financial &#038; Operational Performance" href="https://www.cascobaylines.com/about-us/financial-operational-performance/">Financial &#038; Operational Performance</a></li>
    <li id="menu-item-4623" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Terminal Renovation Project" href="https://www.cascobaylines.com/about-us/terminal-renovation-project/">Terminal Renovation Project</a></li>
    <li id="menu-item-4654" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Fleet Evaluation Project" href="https://www.cascobaylines.com/about-us/fleet-evaluation-project/">Fleet Evaluation Project</a></li>
    <li id="menu-item-4619" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Request for Proposals" href="https://www.cascobaylines.com/request-for-proposals/">Request for Proposals</a></li>
    <li id="menu-item-4624" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Vessels" href="https://www.cascobaylines.com/about-us/vessels/">Vessels</a></li>
    <li id="menu-item-4625" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="U.S. Coast Guard Maritime Security (MARSEC) Levels" href="https://www.cascobaylines.com/about-us/us-coast-guard-maritime-security-marsec-levels/">U.S. Coast Guard Maritime Security (MARSEC) Levels</a></li>
    <li id="menu-item-4626" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Policies" href="https://www.cascobaylines.com/about-us/policies/">Policies</a></li>
    <li id="menu-item-4627" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-no-children"><a title="Newsletter Signup" href="https://www.cascobaylines.com/about-us/newsletter-signup/">Newsletter Signup</a></li>
</ul>
</li>
</ul>                    </nav>
                        
                    <nav id="header-navigation" role="navigation" aria-label="Secondary Navigation">
                        <ul id="menu-header-links" class="menu header-menu"><li id="menu-item-4404" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-4404"><a href="https://www.cascobaylines.com/maine-boat-charters-groups/private-charters/">Private Charters</a></li>
<li id="menu-item-4181" class="menu-item menu-item-type-post_type menu-item-object-page current-page-ancestor menu-item-4181"><a href="https://www.cascobaylines.com/schedules/">Cruise Schedule</a></li>
</ul>                        <ul id="menu-extra-links" class="menu header-menu">
                            <li class="extra-item"><a href="/text-updates/">Get Text Updates</a></li>
                            <li class="extra-item"><div id="google_translate_element"></div></li>
                        </ul>
                    </nav>
                    
                    <script type="text/javascript">function googleTranslateElementInit() { new google.translate.TranslateElement({pageLanguage: "en", gaTrack: true, gaId: "UA-2721489-1"}, "google_translate_element"); }</script><script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
                    
                </div>

            </div>
        </header>

        <div id="content">
            
            
<div id="inner-content" class="container">

    <div class="row row-main has-sidebar1">

        <div id="main" class="col-md-8 order-md-2 col-lg-9 clearfix" role="main">
            
            
<div id="banner">
    <div class="spacer"></div>
</div>
            
                
                    <article id="post-183" class="clearfix post-183 page type-page status-publish hentry" role="article">

                        <header class="page-header">

                            <h1 class="page-title">Peaks Island Winter Schedule</h1>

                        </header>

                        <section class="page-content clearfix">

                            <p style="text-align: center;"><strong>Currently Displaying:</strong> Winter Schedule<br />
<strong>Effective: </strong>Oct 9, 2018 &#8211; Jan 4, 2019<br />
<strong>KEY: cf</strong> = car ferry (transports cars and passengers)</p>
<p>
<table id="tablepress-3" class="tablepress tablepress-id-3">
<thead>
<tr class="row-1 odd">
    <th class="column-1">&nbsp;</th><th colspan="2" class="column-2">Mon.-Thurs.</th>
</tr>
</thead>
<tbody>
<tr class="row-2 even">
    <td class="column-1"></td><td class="column-2">Depart Portland</td><td class="column-3">Depart Peaks</td>
</tr>
<tr class="row-3 odd">
    <td rowspan="5" class="column-1">AM</td><td class="column-2">5:45 cf</td><td class="column-3">6:15 cf</td>
</tr>
<tr class="row-4 even">
    <td class="column-2">6:45 cf</td><td class="column-3">7:15 cf</td>
</tr>
<tr class="row-5 odd">
    <td class="column-2">7:45 cf</td><td class="column-3">8:15 cf</td>
</tr>
<tr class="row-6 even">
    <td class="column-2">9:30 cf</td><td class="column-3">10:00 cf</td>
</tr>
<tr class="row-7 odd">
    <td class="column-2">10:45 cf</td><td class="column-3">11:15 cf</td>
</tr>
<tr class="row-8 even">
    <td rowspan="9" class="column-1">PM</td><td class="column-2">12:15 cf</td><td class="column-3">12:45 cf</td>
</tr>
<tr class="row-9 odd">
    <td class="column-2">2:15 cf</td><td class="column-3">2:45 cf</td>
</tr>
<tr class="row-10 even">
    <td class="column-2">3:15 cf</td><td class="column-3">3:45 cf</td>
</tr>
<tr class="row-11 odd">
    <td class="column-2">4:30 cf</td><td class="column-3">5:00 cf</td>
</tr>
<tr class="row-12 even">
    <td class="column-2">5:35 cf</td><td class="column-3">6:00 cf</td>
</tr>
<tr class="row-13 odd">
    <td class="column-2">7:15</td><td class="column-3">7:45 </td>
</tr>
<tr class="row-14 even">
    <td class="column-2">8:15 </td><td class="column-3">8:45 </td>
</tr>
<tr class="row-15 odd">
    <td class="column-2">9:15 </td><td class="column-3">9:45 </td>
</tr>
<tr class="row-16 even">
    <td class="column-2">10:30</td><td class="column-3">10:55</td>
</tr>
</tbody>
</table>
<!-- #tablepress-3 from cache --><br />

<table id="tablepress-5" class="tablepress tablepress-id-5">
<thead>
<tr class="row-1 odd">
    <th class="column-1"></th><th colspan="2" class="column-2">Friday</th>
</tr>
</thead>
<tbody>
<tr class="row-2 even">
    <td class="column-1"></td><td class="column-2">Departs Portland</td><td class="column-3">Departs Peaks</td>
</tr>
<tr class="row-3 odd">
    <td rowspan="5" class="column-1">AM</td><td class="column-2">5:45 cf</td><td class="column-3">6:15 cf</td>
</tr>
<tr class="row-4 even">
    <td class="column-2">6:45 cf</td><td class="column-3">7:15 cf</td>
</tr>
<tr class="row-5 odd">
    <td class="column-2">7:45 cf</td><td class="column-3">8:15 cf</td>
</tr>
<tr class="row-6 even">
    <td class="column-2">9:30 cf</td><td class="column-3">10:00 cf</td>
</tr>
<tr class="row-7 odd">
    <td class="column-2">10:45 cf</td><td class="column-3">11:15 cf</td>
</tr>
<tr class="row-8 even">
    <td class="column-1">PM</td><td class="column-2">12:15 cf</td><td class="column-3">12:45 cf</td>
</tr>
<tr class="row-9 odd">
    <td rowspan="10" class="column-1"></td><td class="column-2"></td><td class="column-3"></td>
</tr>
<tr class="row-10 even">
    <td class="column-2">2:15 cf</td><td class="column-3">2:45 cf</td>
</tr>
<tr class="row-11 odd">
    <td class="column-2">3:15 cf</td><td class="column-3">3:45 cf</td>
</tr>
<tr class="row-12 even">
    <td class="column-2">4:30 cf</td><td class="column-3">5:00 cf</td>
</tr>
<tr class="row-13 odd">
    <td class="column-2">5:35 cf</td><td class="column-3">6:00 cf</td>
</tr>
<tr class="row-14 even">
    <td class="column-2">7:15 cf</td><td class="column-3">7:45 cf</td>
</tr>
<tr class="row-15 odd">
    <td class="column-2">8:15 cf</td><td class="column-3">8:45 cf</td>
</tr>
<tr class="row-16 even">
    <td class="column-2">9:15 cf</td><td class="column-3">9:45 cf</td>
</tr>
<tr class="row-17 odd">
    <td class="column-2">10:30 cf</td><td class="column-3">10:55 cf</td>
</tr>
<tr class="row-18 even">
    <td class="column-2">11:30 cf</td><td class="column-3">11:55 cf</td>
</tr>
</tbody>
</table>
<!-- #tablepress-5 from cache --><br />

<table id="tablepress-6" class="tablepress tablepress-id-6">
<thead>
<tr class="row-1 odd">
    <th class="column-1">&nbsp;</th><th colspan="2" class="column-2">Saturday </th>
</tr>
</thead>
<tbody>
<tr class="row-2 even">
    <td class="column-1"></td><td class="column-2">Departs Portland</td><td class="column-3">Departs Peaks</td>
</tr>
<tr class="row-3 odd">
    <td rowspan="5" class="column-1">AM</td><td class="column-2">5:45 cf</td><td class="column-3">6:15 cf</td>
</tr>
<tr class="row-4 even">
    <td class="column-2">6:45 cf</td><td class="column-3">7:15 cf</td>
</tr>
<tr class="row-5 odd">
    <td class="column-2">7:45 cf</td><td class="column-3">8:15 cf</td>
</tr>
<tr class="row-6 even">
    <td class="column-2">9:30 cf</td><td class="column-3">10:00 cf</td>
</tr>
<tr class="row-7 odd">
    <td class="column-2">10:45 cf</td><td class="column-3">11:15 cf</td>
</tr>
<tr class="row-8 even">
    <td rowspan="10" class="column-1">PM</td><td class="column-2">12:15 cf</td><td class="column-3">12:45 cf</td>
</tr>
<tr class="row-9 odd">
    <td class="column-2">2:15 cf</td><td class="column-3">2:45 cf</td>
</tr>
<tr class="row-10 even">
    <td class="column-2">3:15 cf</td><td class="column-3">3:45 cf</td>
</tr>
<tr class="row-11 odd">
    <td class="column-2">4:30 cf</td><td class="column-3">5:00 cf</td>
</tr>
<tr class="row-12 even">
    <td class="column-2">5:35 cf</td><td class="column-3">6:00 cf</td>
</tr>
<tr class="row-13 odd">
    <td class="column-2">7:15 </td><td class="column-3">7:45 </td>
</tr>
<tr class="row-14 even">
    <td class="column-2">8:15 </td><td class="column-3">8:45 </td>
</tr>
<tr class="row-15 odd">
    <td class="column-2">9:15 </td><td class="column-3">9:45 </td>
</tr>
<tr class="row-16 even">
    <td class="column-2">10:30 </td><td class="column-3">10:55 </td>
</tr>
<tr class="row-17 odd">
    <td class="column-2">11:30 </td><td class="column-3">11:55 </td>
</tr>
</tbody>
</table>
<!-- #tablepress-6 from cache --><br />

<table id="tablepress-8" class="tablepress tablepress-id-8">
<thead>
<tr class="row-1 odd">
    <th class="column-1">&nbsp;</th><th colspan="2" class="column-2">Sun/Holiday</th>
</tr>
</thead>
<tbody>
<tr class="row-2 even">
    <td class="column-1"></td><td class="column-2">Departs Portland</td><td class="column-3">Departs Peaks</td>
</tr>
<tr class="row-3 odd">
    <td rowspan="4" class="column-1">AM</td><td class="column-2">6:45 cf</td><td class="column-3">7:15 cf</td>
</tr>
<tr class="row-4 even">
    <td class="column-2">7:45 cf</td><td class="column-3">8:15 cf</td>
</tr>
<tr class="row-5 odd">
    <td class="column-2">9:30 cf</td><td class="column-3">10:00 cf</td>
</tr>
<tr class="row-6 even">
    <td class="column-2">10:45 cf</td><td class="column-3">11:15 cf</td>
</tr>
<tr class="row-7 odd">
    <td rowspan="9" class="column-1">PM</td><td class="column-2">12:15 cf</td><td class="column-3">12:45 cf</td>
</tr>
<tr class="row-8 even">
    <td class="column-2">2:15 cf</td><td class="column-3">2:45 cf</td>
</tr>
<tr class="row-9 odd">
    <td class="column-2">3:15 cf</td><td class="column-3">3:45 cf</td>
</tr>
<tr class="row-10 even">
    <td class="column-2">4:30 cf</td><td class="column-3">5:00 cf</td>
</tr>
<tr class="row-11 odd">
    <td class="column-2">5:35 cf</td><td class="column-3">6:00 cf</td>
</tr>
<tr class="row-12 even">
    <td class="column-2">7:15</td><td class="column-3">7:45 </td>
</tr>
<tr class="row-13 odd">
    <td class="column-2">8:15</td><td class="column-3">8:45 </td>
</tr>
<tr class="row-14 even">
    <td class="column-2">9:15</td><td class="column-3">9:45</td>
</tr>
<tr class="row-15 odd">
    <td class="column-2"></td><td class="column-3"></td>
</tr>
</tbody>
</table>
<!-- #tablepress-8 from cache --></p>
<p style="text-align: center;"><strong>Holiday Schedule is on:</strong><br />
Veteran&#8217;s Day<br />
Thanksgiving<br />
Christmas Day<br />
New Year&#8217;s Day</p>
<p style="text-align: center;"><strong>On Christmas Eve last trip:</strong><br />
to Peaks Island at 9:15 PM<br />
from Peaks Island at 9:45 PM</p>
<p style="text-align: center;"><strong>On New Year&#8217;s Eve last trip:</strong><br />
to Peaks Island at 10:30 PM<br />
from Peaks Island at 10:55 PM</p>
<p style="text-align: center;"><strong>New Year&#8217;s Eve Special:</strong><br />
1:00 AM departure to all islands</p>

                                                        
                            

                         </section>

                        
                    </article>

                
                        
        </div>
        

    <div id="left-sidebar" class="sidebar col-md-4 order-md-1 col-lg-3" role="complementary">
        <div id="left-sidebar__inner">
            <div id="nav_menu-8" class="widget widget_nav_menu"><div class="menu-schedules-sidebar-container"><ul id="menu-schedules-sidebar" class="menu"><li id="menu-item-532" class="menu-item menu-item-type-post_type menu-item-object-page current-page-ancestor current-menu-ancestor current_page_ancestor menu-item-has-children menu-item-532"><a title="Schedules" href="https://www.cascobaylines.com/schedules/">Schedules</a>
<ul class="sub-menu">
    <li id="menu-item-685" class="menu-item menu-item-type-post_type menu-item-object-page current-page-ancestor current-menu-ancestor current-menu-parent current-page-parent current_page_parent current_page_ancestor menu-item-has-children menu-item-685"><a title="Peaks Island Schedule" href="https://www.cascobaylines.com/schedules/peaks-island-schedule/">Peaks Island Schedule</a>
    <ul class="sub-menu">
        <li id="menu-item-689" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-689"><a title="Peaks Island Spring Schedule" href="https://www.cascobaylines.com/schedules/peaks-island-schedule/spring/">Spring</a></li>
        <li id="menu-item-690" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-690"><a title="Peaks Island Summer Schedule" href="https://www.cascobaylines.com/schedules/peaks-island-schedule/summer/">Summer</a></li>
        <li id="menu-item-695" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-695"><a title="Peaks Island Fall Schedule" href="https://www.cascobaylines.com/schedules/peaks-island-schedule/fall/">Fall</a></li>
        <li id="menu-item-691" class="menu-item menu-item-type-post_type menu-item-object-page current-menu-item page_item page-item-183 current_page_item menu-item-691"><a title="Peaks Island Winter Schedule" href="https://www.cascobaylines.com/schedules/peaks-island-schedule/winter/">Winter</a></li>
    </ul>
</li>
    <li id="menu-item-700" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-700"><a title="Little Diamond Island Schedule" href="https://www.cascobaylines.com/schedules/little-diamond-island-schedule/">Little Diamond Island Schedule</a>
    <ul class="sub-menu">
        <li id="menu-item-718" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-718"><a title="Little Diamond Island Spring Schedule" href="https://www.cascobaylines.com/schedules/little-diamond-island-schedule/spring/">Spring</a></li>
        <li id="menu-item-719" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-719"><a title="Little Diamond Island Summer Schedule" href="https://www.cascobaylines.com/schedules/little-diamond-island-schedule/summer/">Summer</a></li>
        <li id="menu-item-705" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-705"><a title="Little Diamond Island Fall Schedule" href="https://www.cascobaylines.com/schedules/little-diamond-island-schedule/fall/">Fall</a></li>
        <li id="menu-item-1660" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-1660"><a title="Little Diamond Island Winter Schedule" href="https://www.cascobaylines.com/schedules/little-diamond-island-schedule/winter/">Winter</a></li>
    </ul>
</li>
    <li id="menu-item-699" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-699"><a title="Great Diamond Island Schedule" href="https://www.cascobaylines.com/schedules/great-diamond-schedule/">Great Diamond Island Schedule</a>
    <ul class="sub-menu">
        <li id="menu-item-715" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-715"><a title="Great Diamond Island Spring Schedule" href="https://www.cascobaylines.com/schedules/great-diamond-schedule/spring/">Spring</a></li>
        <li id="menu-item-716" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-716"><a title="Great Diamond Island Summer Schedule" href="https://www.cascobaylines.com/schedules/great-diamond-schedule/summer/">Summer</a></li>
        <li id="menu-item-704" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-704"><a title="Great Diamond Island Fall Schedule" href="https://www.cascobaylines.com/schedules/great-diamond-schedule/fall/">Fall</a></li>
        <li id="menu-item-739" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-739"><a title="Great Diamond Island Winter Schedule" href="https://www.cascobaylines.com/schedules/great-diamond-schedule/winter/">Winter</a></li>
    </ul>
</li>
    <li id="menu-item-698" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-698"><a title="Diamond Cove Schedule" href="https://www.cascobaylines.com/schedules/diamond-cove-schedule/">Diamond Cove Schedule</a>
    <ul class="sub-menu">
        <li id="menu-item-712" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-712"><a title="Diamond Cove Spring Schedule" href="https://www.cascobaylines.com/schedules/diamond-cove-schedule/spring/">Spring</a></li>
        <li id="menu-item-713" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-713"><a title="Diamond Cove Summer Schedule" href="https://www.cascobaylines.com/schedules/diamond-cove-schedule/summe/">Summer</a></li>
        <li id="menu-item-703" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-703"><a title="Diamond Cove Fall Schedule" href="https://www.cascobaylines.com/schedules/diamond-cove-schedule/fall/">Fall</a></li>
        <li id="menu-item-714" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-714"><a title="Diamond Cove Winter Schedule" href="https://www.cascobaylines.com/schedules/diamond-cove-schedule/winter/">Winter</a></li>
    </ul>
</li>
    <li id="menu-item-701" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-701"><a title="Long Island Schedule" href="https://www.cascobaylines.com/schedules/long-island-schedule/">Long Island Schedule</a>
    <ul class="sub-menu">
        <li id="menu-item-720" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-720"><a title="Long Island Spring Schedule" href="https://www.cascobaylines.com/schedules/long-island-schedule/spring/">Spring</a></li>
        <li id="menu-item-721" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-721"><a title="Long Island Summer Schedule" href="https://www.cascobaylines.com/schedules/long-island-schedule/summer/">Summer</a></li>
        <li id="menu-item-706" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-706"><a title="Long Island Fall Schedule" href="https://www.cascobaylines.com/schedules/long-island-schedule/fall/">Fall</a></li>
        <li id="menu-item-722" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-722"><a title="Long Island Winter Schedule" href="https://www.cascobaylines.com/schedules/long-island-schedule/winter/">Winter</a></li>
    </ul>
</li>
    <li id="menu-item-696" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-696"><a title="Chebeague Island Schedule" href="https://www.cascobaylines.com/schedules/chebeague-island-schedule/">Chebeague Island Schedule</a>
    <ul class="sub-menu">
        <li id="menu-item-709" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-709"><a title="Chebeague Island Spring Schedule" href="https://www.cascobaylines.com/schedules/chebeague-island-schedule/spring/">Spring</a></li>
        <li id="menu-item-710" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-710"><a title="Chebeague Island Summer Schedule" href="https://www.cascobaylines.com/schedules/chebeague-island-schedule/summer/">Summer</a></li>
        <li id="menu-item-702" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-702"><a title="Chebeague Island Fall Schedule" href="https://www.cascobaylines.com/schedules/chebeague-island-schedule/fall/">Fall</a></li>
        <li id="menu-item-711" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-711"><a title="Chebeague Island Winter Schedule" href="https://www.cascobaylines.com/schedules/chebeague-island-schedule/winter/">Winter</a></li>
    </ul>
</li>
    <li id="menu-item-697" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-697"><a title="Cliff Island Schedule" href="https://www.cascobaylines.com/schedules/cliff-island-schedule/">Cliff Island Schedule</a>
    <ul class="sub-menu">
        <li id="menu-item-1663" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-1663"><a title="Cliff Island Spring Schedule" href="https://www.cascobaylines.com/schedules/cliff-island-schedule/spring/">Spring</a></li>
        <li id="menu-item-723" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-723"><a title="Cliff Island Summer Schedule" href="https://www.cascobaylines.com/schedules/cliff-island-schedule/summer/">Summer</a></li>
        <li id="menu-item-1662" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-1662"><a title="Cliff Island Fall Schedule" href="https://www.cascobaylines.com/schedules/cliff-island-schedule/fall/">Fall</a></li>
        <li id="menu-item-1661" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-1661"><a title="Cliff Island Winter Schedule" href="https://www.cascobaylines.com/schedules/cliff-island-schedule/winter/">Winter</a></li>
    </ul>
</li>
</ul>
</li>
<li id="menu-item-1700" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-1700"><a href="https://www.cascobaylines.com/schedules/bailey-island-schedule/">Bailey Island Schedule</a></li>
<li id="menu-item-1620" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-1620"><a title="Specialty Cruises" href="https://www.cascobaylines.com/maine-boat-tours/specialty-cruises/">Specialty Cruises</a></li>
</ul></div></div>        </div>
    </div>


        
    </div>
</div>

            
        </div>
        <footer id="colophon" class="footer" role="contentinfo">
            
            <div id="inner-footer-wrap">

                <div id="inner-footer" class="container">

                    <nav role="navigation" aria-label="Footer Navigation">
                        <ul id="menu-footer-links" class="menu footer-menu"><li id="menu-item-54" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-54"><a title="Employee Portal" href="https://www.cascobaylines.com/employee-portal/">Employee Portal</a></li>
<li id="menu-item-53" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-53"><a title="Site Map" href="https://www.cascobaylines.com/site-map/">Site Map</a></li>
<li id="menu-item-1117" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-1117"><a title="Terms of Use" href="https://www.cascobaylines.com/terms-of-use/">Terms of Use</a></li>
<li id="menu-item-52" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-52"><a title="Privacy Policy" href="https://www.cascobaylines.com/privacy-policy/">Privacy Policy</a></li>
<li id="menu-item-51" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-51"><a title="Policies" href="https://www.cascobaylines.com/about-us/policies/">Policies</a></li>
</ul>                    </nav>
                    
                                        <address class="footer-address">
                        <span class="address-item">56 Commercial Street, Portland, Maine 04101</span>
                        <span class="address-item">Phone: <a href="tel:+1-207-774-7871">(207) 774-7871</a></span>
                        <span class="address-item">Fax: (207) 774-7875</span>
                        <span class="address-item">Email: <span id="eeb-630828"></span><script type="text/javascript">(function(){var ml="F2khArs3eDy%lt0-4acmEbCon.if",mi=";7FA;1>358K;79;11CAJ<=G;74JHKG;@>BA6BGEA:<JH86IBGC;11;1>;1>B<A66;79;11CAJ<=G?<JH2;11;7DJHKG;@>BA6BGEA:<JH86IBGC;7F;10A;7D",o="";for(var j=0,l=mi.length;j<l;j++){o+=ml.charAt(mi.charCodeAt(j)-48);}document.getElementById("eeb-630828").innerHTML = decodeURIComponent(o);}());</script><noscript>*protected email*</noscript></span>
                    </address>

                    <p class="bold-footer-statement"><b>Year-round ferry services, scenic cruises and boat tours from Portland, Maine to the islands of Casco Bay, including: Peaks, Little Diamond, Great Diamond, Diamond Cove, Long, Chebeague, Cliff, and Bailey Island.</b></p>
                    
                    <ul class="footer-social-icons list-style--social">
                        <li><a href="https://www.facebook.com/CascoBayLines" title="Casco Bay Lines Facebook" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
                        <li><a href="https://twitter.com/cascobaylines" title="Casco Bay Lines Twitter" target="_blank"><i class="fab fa-twitter"></i></a></li>
                        <li><a href="https://vimeo.com/user66802670" title="Casco Bay Lines Vimeo" target="_blank"><i class="fab fa-vimeo-v"></i></a></li>
                        <li><a href="https://www.cascobaylines.com/ferry-news/feed/" title="Casco Bay Lines RSS Feed" target="_blank"><i class="fas fa-rss"></i></a></li>
                    </ul>
                    
                    <p class="source-org copyright">&copy; 2018 Casco Bay Island Transit District.</p>

                </div>
                
            </div>

        </footer>

        <p id="back-top">
            <a href="#top"><i class="fas fa-angle-up"></i></a>
        </p>

    </div>
<script type='text/javascript' src='https://www.cascobaylines.com/wp-content/themes/cascobaylines/libs/js/jquery.magnific-popup.min.js?ver=1.1.0'></script>
<script type='text/javascript' src='https://www.cascobaylines.com/wp-content/themes/cascobaylines/libs/js/selectWoo.full.min.js?ver=1.0.2'></script>
<script type='text/javascript' src='https://www.cascobaylines.com/wp-content/themes/cascobaylines/js/scripts.min.js?ver=20180821'></script>
<script type='text/javascript' src='https://www.cascobaylines.com/wp-includes/js/wp-embed.min.js?ver=4.9.8'></script>

</body>
</html>
""".data(using: .utf8)!
