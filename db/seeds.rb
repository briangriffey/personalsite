# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

BlogPost.create({content: "<h1>No Fragments, Rich Views</h1>
<h5>Android Development at HomeAway part 1</h5>

I've seen a lot of debate on Twitter recently regarding Fragments.  Are they good, bad, or neutral in Android development? We at HomeAway don't use Fragments, we use a development philosophy that we call \"rich views\" that we feel takes the best and simplest route to providing good, reusable and testable code.

<h3> Why not Fragments?</h3>
<p>
We don't use fragments, simply because we don't need to. Fragments have a tremendous amount of lifecycle events that can be difficult to manage, and at the end of the day are fairly unnecessary. Let's take a look at the fragment life cycle straight from http://developer.android.com/reference/android/app/Fragment.html#Lifecycle
</p>


<pre>
onAttach(Activity) called once the fragment is associated with its activity.
onCreate(Bundle) called to do initial creation of the fragment.
onCreateView(LayoutInflater, ViewGroup, Bundle) creates and returns the view hierarchy associated with the fragment.
onActivityCreated(Bundle) tells the fragment that its activity has completed its own Activity.onCreate().
onViewStateRestored(Bundle) tells the fragment that all of the saved state of its view hierarchy has been restored.
onStart() makes the fragment visible to the user (based on its containing activity being started).
onResume() makes the fragment interacting with the user (based on its containing activity being resumed).
As a fragment is no longer being used, it goes through a reverse series of callbacks:

onPause() fragment is no longer interacting with the user either because its activity is being paused or a fragment operation is modifying it in the activity.
onStop() fragment is no longer visible to the user either because its activity is being stopped or a fragment operation is modifying it in the activity.
onDestroyView() allows the fragment to clean up resources associated with its View.
onDestroy() called to do final cleanup of the fragment's state.
onDetach() called immediately prior to the fragment no longer being associated with its activity.
</pre>
<p>
Whew! 12 methods in total; that's a lot of methods! All to handle state. On top of all of this there's also the FragmentManager, which you can use to find fragments to ask things such as isAdded(), isDetached(), isHidden(), isInLayout(), isRemoving(), isResumed(), and isVisible(). Alright, you guys get my point.
</p>
<p>
What advantages are you gaining for having to learn all of these method calls? From our perspective, not a lot. The goal of fragments, as I see it, has always been to write clean MVC code. Fragments are really just a packaged way to inflate a view, grab references to sub views, provide a place to put simple logic in handling those sub-views, and then save and restore state; and the FragmentManager is responsible for adding and removing those inflated views from the current view hierarchy.
</p>
<p>
So what's an easier route to do all of these things? The answer is pretty simple and it's been around since the beginning of Android, Views!
</p>

<h3>What's in a view</h3>
<p>
Views have been around in Android since the very beginning, they're one of the most basic building blocks. Every time you create a new application you'll start with the default Hello World activity that contains a reference to a TextView. The first thing you probably did as an Android developer was change that text to something else like \"This is awesome!\", run it on your phone, then proudly wave your phone around in the air showing it to all your friends. During this wild waving you probably did something to cause the app to background itself (like accidently hitting the app switcher or the home button), but when you switched back to your app it was just as you left it. Why is that? Well, all of the built in Android views implement onSaveInstanceState and onRestoreInstanceState found inside of every View.
</p>
<p>
So, how can we use this magnificent fact to create something that duplicates most of the functionality of fragments without most of the headaches? I propose that we extend Android's provided container types that already handle state, and lean on them for the heavy lifting. This is what we call rich views; extending framework types, a lot of the time a FrameLayout, and adding logic into them to suite our needs for displaying a model or handling UI interactions.  Earlier I made a list of what I thought Fragments were good at,let's go through those using an example of a view that handles an imaginary Quote object that might contain information regarding a payment on a rental property.
</p>

<h4>Inflating a view</h4>
<p>
This one's easy, any Viewgroup already has methods for adding and removing subviews. We can simply inflate any xml we want in our constructor; for example
</p>

<pre>
public class QuoteView extends FrameLayout {
  //constructors you'll need to support
  public QuoteView(Context context) {
    super(context);
    init();
  }

  public QuoteView(Context context, AttributeSet set) {
    super(context, set);
    init();
  }

  private void init() {
    //grab a layout inflater, and inflate R.layout.view_quote, into this FrameLayout
    LayoutInflater.from(getContext())
                  .inflate(R.layout.view_quote, this, true);
  }

}
</pre>


That's it, we're done. We've now added our layout defined in XML to this view. This is the same exact process that a Fragment uses during the onCreateView method. The Fragment constructs a non state saving FrameLayout, hands you an inflater, and then has you inflate xml with that FrameLayout as the parent ViewGroup. Here we have the freedom to actually attach our inflated view to the ViewGroup though, if you try that in a Fragment it'll throw an error because it'll try re-add the inflated view and crash; one of those nice gotchas.

<h4>Grabbing references to sub views</h4>
Getting references to subviews is now amazingly easy because of a wonderful library provided by Jake Wharton called <a href=\"http://jakewharton.github.io/butterknife/\">ButterKnife</a>. ButterKnife allows you to use simple annotations to wire views into any object by calling ButterKnife.inject, no more more messy findViewById nonsense. Although you can still do that if you want to. Let's wire up our Quote View by adding some fields and changing our init function slightly. Here's the new version.

<pre>
public class QuoteView extends FrameLayout {
  @InjectView(R.id.view_quote_total)
  TextView mQuotetotal;
  @InjectView(R.id.view_quote_checkin_date)
  TextView mCheckinDate;
  @InjectView(R.id.view_quote_payment_breakdown)
  PaymentBreakdownView mPaymentBreakdown;

  //omitted code from earlier....

  private void init() {
    //grab a layout inflater, and inflate R.layout.view_quote, into this FrameLayout
    LayoutInflater.from(getContext())
                  .inflate(R.layout.view_quote, this, true);
    ButterKnife.inject(this);
  }

}
</pre>
<p>
Our QuoteView now knows about three of its subviews, one to display the quote total, one to display the check-in date, and another rich view to display the payment breakdown. As long as those views are in our view_quote layout file, they'll be assigned to our fields. Another good thing about ButterKnife is: if the view ids don't exist in view_quote then the inject function will throw an error which can be easily detected using unit tests and Robolectric. Each of our rich views has an accompanying unit test that will find such errors, and free us from the pain of a null view being returned by findViewById leading to an uncaught NPE down the road.
</p>

<h4>Provide a place to handle display logic and UI element interaction</h4>
<p>
Here's where we really get into the fun stuff.  When fragments first came out developers were excited because it gave them a way to take their 1000 line Activity class and break that up into a few, several hundred line classes. A lot of applications spend a majority of their time in following pattern: launch activity, get DTOs from server, then display DTOs in the UI. Fragments provided a way to break some of this into chunks, allowing a Fragment to handle sections of the UI (the jury is still out on how you should actually give your DTO to the fragment, do you create a newInstance method, or an empty constructor and then setArguments? Wait, why are we putting stuff in a Bundle? I have to remember bundle keys now? wtf).  Let's use simple setters on our views here (like sane people)
</p>

<pre>
public class QuoteView extends FrameLayout {
  @InjectView(R.id.view_quote_total)
  TextView mQuotetotal;
  @InjectView(R.id.view_quote_checkin_date)
  TextView mCheckinDate;
  @InjectView(R.id.view_quote_payment_breakdown)
  PaymentBreakdownView mPaymentBreakdown;

  //omitted code from earlier....
  public void setQuote(Quote quote) {
    //set out text views from out DTO
    mQuotetotal.setText(quote.getQuoteTotal());
    mCheckInDate.setText(quote.getCheckinDate(\"yyyy-MM-dd\"));

    //set our PaymentBreakdownView to handle it's own display logic
    mPaymentBreakdown.setPaymentBreakdown(quote.getPaymentSchedule());
  }
}
</pre>
<p>
There we go, easy as pie to display data that we got over the network.
</p>
<p>
That's it for now, I'm going on vacation so watch for part 2 next week that will cover interacting with UI elements, and state management pieces of our applications.
</p>"})

BlogPost.create({content: "<h1>No Fragments, Rich Views</h1>
<h5>Android Development at HomeAway part 2</h5>
<p>
Sorry for the long delay in writing this. I've found it quite hard to articulate my thoughts and layout a coherent article, so I'm taking the continuous release approach. Release early, release often.
</p>

<h3>Saving state</h3>
<p>So where do we save all of our state? UI state is easy. If you are using standard Android widgets, then there's nothing for you to do. Anything that extends a standard Android widget already has its onSaveInstanceState and onRestoreInstanceState filled out. Android will even restore your views just the way they were when your Activity is created and destroyed.  That's why when you rotate your phone your UI doesn't change</p>

<p>
  So what about non-UI state? Where do we save all of our data that we fetched from the server, or track our requests that are mid-flight when our Activity is created or destroyed? The answer is nowhere near anything with a lifecycle. We use <a href=\"http://square.github.io/dagger/\">Dagger</a>, a dependency injection framework, to build a set of \"Manager\" objects that are free of activity lifecycles and handle the fetching, storing, and caching of data that we get from our servers.  Dagger injects our activities with our \"manager\" objects they can use to fetch data. Here's a simple version of how we might setup a system like this.
</p>

<h3>Code snippets</h3>
<pre>
  //class for fetching owner data
  public class OwnerManager {
    private DiskLruCache mDataCache;

    //skipped code that sets up the cache, constructor, etc

    public void getPropertyList(String user, final Response.Listener<PropertyList> listener, final ErrorListener errorListener) {
      //have we fetched this data before? Yes, sweet return it
      if(isCached(property)) {

        PropertyList list = getCached(user);
        listener.onResponse(list);

      } else {

        //go get stuff from the network asynchronously, cache it, and return to the listener
        getFromNetwork(user, new Response.Listener<PropertyList>() {

          public void onResponse(PropertyList list) {
            //pass back a non-modifiable property list to the user
            // must use the ownermanager to modify data
            PropertyList nonModifiableLIst = createNonModifiable(list);
            listener.onResponse(nonModifiableLIst);
            saveDataToCache(list);
          }

        }, new ErrorListener() {

          public void onError(Error error) {
            //do some stuff with this error
            errorListener.onError(error);
          }

        });
      }
    }
    //so much other stuff
  }
</pre>

<pre>
  //dagger module that will create one ownermanger for the entire application
  @Module(injects = {ListPropertyActivity.class})
  public class HAModule {
    @Provides
    @Singleton
    public OwnerManager getOwnerManager() {
      return new OwnerManager();
    }
  }
</pre>

<pre>
  public class ListPropertyActivity extends ListActivity {

    @Inject OwnerManager ownerManager;

    public void onCreate(Bundle savedInstanceState) {
      HomeAwayApplication app = (HomeAwayApplication)getApplicationContext();
      app.inject(this);

      String user = getIntent().getStringExtra(\"user\");

      //Rotate all you want, we just get the data from our ownermanager
      ownerManager.getPropertyList(user, propertyListener, errorListener);
    }

    private Response.Listener<PropertyList> propertyListListener = new LifecycleAwareListener<PropertyList>(this) {
      public void onResponse(PropertyList list) {
        getListView().setAdapter(new GreatAdapter(list));
      }
    }

    private ErrorListener errorListener = new LifecycleAwareErrorListener(this) {
      public void onError(Error error) {
        //wa waaaaaa
        showErrorView();
      }
    }
  }
</pre>

<p>
  As you can see above, our OwnerManager is able to handle data as it sees fit, free from the shackles of lifecycle events. When our activity is created, we don't really care whether it's from some saved state or not. We simply ask the OwnerManager for the data, and we'll get a callback when it's available, or if there was an error.  The OwnerManager is the source of truth for owner data, no need to hold (mostly) anything in the activity.
<p>
  Having stand alone objects control our data fetching and storage gives us a lot of flexibility inside of our application. We are free to use more common design patterns and libraries rather than being tied to something android specific.  It also allows us to reuse these objects in SyncAdapters to easily add sync capability to our applications. I'll cover that next post
</p>"})
