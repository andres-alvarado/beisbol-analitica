# Chapter 8 - The Book... and The Computer

Baseball, like poker, is a game in which the situations vary within a defined range and so may be modeled mathematically; within such a model, the probability of a particular tactic's being successful calculated. This is attested to by the time-honored tendency of managers to ***play the percentages*** not only because over the long haul percentage baseball is winning baseball but also because pilots by calling upon higher authority in the form of “The Book”, deflect much of the second-guessing what works against career longevity. But how can whole armies of managers claim to play the percentages if they don't know what they are?

As Pete Palmer said, ***You know, all these managers talk about playing by The Book, but they've never even read The Book. They don't know what's in it. They all use the same old strategies, many of which are ridiculous. Every mathematical analysis I've seen shows that the intentional walk is almost always a bad play, stolen bases are only marginally useful, and the sacrifice bunt is a relatively useless vestige of the deadball era when they didn't pinch-hit for pitchers.***

Of course, when baseball people talk about The Book, they don't mean anything that's bound between hard covers (or, these days, soft). They're referring to the folk wisdom that has built up through trial and error. Most of the significant elements of strategy go back before the turn of the century( the steal, the sacrifice, the hit and run,  the classic ***percentage play*** of pinch-hitting a left handed batter against a right handed pitcher).

Then, as now, percentage play consisted of nothing more than achieving the greatest possible gain in run scoring or run prevention while assuming the least possible risk. As the penalty for failure increases, so must the reward; otherwise the percentages are said to be working against you.

The same maneuvers that Ned Hanlon, Connie Mack, and John McGraw used with so much success in the era of the dead ball have remained articles of faith for managers throughout the explosive hitting period between the wars and continue to be revered today. The old defense of outmoded practices,  ***We've always done it that way***) bespeaks a conservative's preference to deal with the known rather than the unknown, until he is convinced of the former's utter, irredeemable inadequacy. The old code survives even when the circumstances which brought it into being vanished long ago.

But what happened to this idea, born of a particular time and particular conditions, was that it became entrenched and grew, spreading itself into other times and other conditions which would not have been fertile for its invention.

The computer enables us to analyze masses of data, establish run values for situations and events, and evaluate the options available to a manager or player.

As it was earlier expressed the statistics of individuals to reflect their runs contributed or saved, so we can examine the elements of strategy to reflect their potential runs gained in the event of success, or lost in the event of failure. We will need to know:  (a) the potential run-scoring situation that exists before a contemplated tactic is employed (b) the run potential that would result if the move succeeded; and  (c) |the run potential remaining if it failed. Armed with this information, a manager or fan can weigh the possible gain against the possible loss. He can determine objectively whether the tactic is indeed a percentage play or should be blue-penciled out of The Book.

In order to calculate the expected run value of each possible strategy, Pete Palmer first calculated the run potential for the given situation regardless of the score and second, the probability of winning the game. These two calculations are different because a  strategy may have far more consequence in the seventh, eighth, or ninth innings than it does early on; the sacrifice bunt or the intentional base on balls may not be distributed randomly over the course of a game.

Palmer also calculated the number of potential runs for each of the twenty four base out situations. Below table shows the run potential calculated by Palmer for the period 1961-1977.

|         |       |  Outs |      |
|:-------:|:-----:|:-----:|:----:|
| Runners |   0   |   1   |   2  |
|   ---   |  .454 |  .249 | .095 |
|   1--   |  .783 |  .478 | .209 |
|   -2-   | 1.068 |  .699 | .348 |
|   --3   | 1.277 |  .897 | .382 |
|   12-   | 1.380 |  .888 | .457 |
|   1-3   | 1.639 | 1.088 | .494 |
|   2-3   | 1.946 | 1.371 | .661 |
|   123   | 2.254 | 1.546 | .798 |

At the beginning of a half inning, with nobody out and no runners on base, the run-scoring potential was .454. In rough terms, over the last decade or so teams have tended to score about 4.5 runs, which breaks down to about half a run per inning.  Why, then, is the figure in the table .454 and not .500? First, because a victorious home team does not bat in nine innings, but eight (except when the victory is gained in the ninth); second, because during most of the 1960s pitching dominated, so that the average team scored somewhat less than 4.5 runs.

If there is a man on third and one out, the team should score, on average .897 runs. What does that mean? That 89.7 percent of the time, the man on third should score? No, not exactly: It means that the 2 run-scoring potential is .897 as a function of there being a man on third and at least two additional batters in the half inning, barring a double play, pickoff, or failed steal attempt. Totaling the run potential of the man on third plus that of the two additional batters, who may get on base themselves, provides the .897. In the case of the first batter, let's say that no one was on base, then the run potential for the team would be .249. Thus we see that the situation this batter confronts .249 of the team's run value is attributable to the batter's possibility of reaching base, bringing up not only the next batter but perhaps several more, depending upon the outcomes. This means that of the run value inherent in the situation “man on third, one out** (namely .897), .249 resides with the batter(s) and .648 with the baserunner.

That said: What is the break-even point for a strategy? Where do risk and reward intersect, and what is the “percentage play**? To find the break-even point, we must identify the point at which the run value that exists before that strategy employed equals the run value after the strategy has been employed. This may be he as as is expressed as an equation:

`Pb x Vs +  (1 – Pb ) x Vf = Vp`

`Pb` is the probability of attaining the break-even point with a given strategy. `Vs` is the value of a success, while `Vf` is the value of a failure. `Vp` stands for the present value(i. e. before the strategy has been set in motion). Rearranging terms so as to set the break-even point off to one side, since this is what we are trying to find, we get:

`Pb =  (Vp - Vf) /  (Vs - Vt)`

## The Sacrifice

The potential run value is always lower after a successful sacrifice. With the introduction of the lively ball, the sacrifice bunt should have vanished, except perhaps for situations in which the pitcher is allowed to come to the plate in the late innings with a man on first. The sac bunt by any other man in the order should have become as infrequent a mode of strategy as the squeeze play. The sacrifice has been used promiscuously because the risk attached to it has not been as obvious (the statement holds true for the steal attempt too). You can’t give up an out. The ***successful*** bunt reduces the potential offense for your team in a half inning.

## The Steal

The stolen base, as indicated in the chapter on the Linear Weights System, is an overrated play, with even the best base stealers contributing a few extra runs or wins to their teams. The reason for this is that the break-even point is so high, roughly two steals in three attempts. The precise figure can be obtained from the Run Expectancy Table and the break-even point equation.  A runner on first with no outs is worth .478 A steal of second increases this to.699; a failure leaves no one on base and two out, worth .095.

`Pb =  (.478 -.095) / (.699 -.095) = .634`

What about stealing other bases? Your team will suffer far more for your being thrown out than it will benefit from your gaining third, because it stands a pretty good chance of scoring already, simply by there being a man at second base,

Stealing home without is a good play, a far better percentage play than stealing third: Because of the enormous potential gain as compared to the risk, you need a 35 percent probability of success in order to break even:

`Pb =  (.382 -.000) / (1.095 –.000) = .349`

## The Intentional Base on Balls

And just as Palmer showed that the sacrifice bunt never lifts the team's expected run value, so does it show that the intentional base on balls never reduces the expected number of runs scored, However, there are cases in which an IBB will lower the batting team's chance of winning the game.

Because the pitcher is permitted to bat in the National League, an intentional base on balls is frequently issued when there are two out, one or two men on, a base open, and the eighth-place batter is at the plate. This is the classic use of the IBB(not to set up a force play but to work to a batter of lesser ability). This move reduces slightly the probability of a run scoring in that half inning but the reduction is more than offset by the enhanced probability of the team scoring in its next turn at bat). This is because the next inning, instead of beginning with the pitcher batting, opens with the number one hitter. If the pitcher is retired, the defense may have saved a run or two, but the offense starts the next inning in a more beneficial situation.

## The Batting Order

In his Percentage Baseball of 1964, Earnshaw Cook realized correctly that over the course of a season the leadoff batter had more at bats than the other eight spots; the second batter had more than the seven men below him; and so on. So, he reasoned, why not give the team’s best hitters the maximum number of at bats so that they might achieve more hits and thus produce more runs?

## The Computer

The computer enables play-by-play( indeed pitch by pitch ) recording and analysis, which would, among other things permit us to improve advanced metrics.

By storing play-by-play data for future analysis, the computer permits managers to keep track of how individual batters fare against individual pitchers and vice versa, or how players perform under a myriad of varying conditions( i.e day vs. night, artificial turf vs. grass, curveball vs. fastball, etc. ).

With proper input, a computer can tell you how frequently steal attempts succeed against a particular catcher or, more interestingly. pitcher. Or it may reveal how a batter has fared against a particular pitcher.

If the general manager of the Braves wanted to judge what would have happened to his team in 1983 had he picked up Rick Honeycutt or Sixto Lezcano rather than letting them go to other clubs, a computer model could tell him. A computer can run through an entire season with one new variable in a few minutes, so a front office can construct a scenario for a prospective trade that will predict the difference the new player (s) will make in the team's won-lost record. And that will tell the G. M., if he wants to dance, how much to pay the piper.

The computer can help a team adjust to the features of a road ballpark. It can help a manager decide whether to unleash his jackrabbits when playing in Toronto or Seattle, or restrain them in New York or Detroit

Those managers who persist in the old seat-of-the-pants wisdom known as The Book are not playing the percentages, they are playing with dynamite. Unbeknownst to themselves, they are not percentage players but hunch players(no matter that their hunches are backed by tradition). In the long run, hunch players fail.

By analyzing events of all kinds in terms of their run-scoring potential and win probability, aided by the computer, the percentages need not be a matter for debate. The Book is no longer a figure of speech or a figment of the imagination, but a real book.
