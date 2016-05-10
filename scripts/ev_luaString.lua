require'ohnn'

--local str = "It's a Masterpiece ! I like this movie !"

--local str = "It's so disappointed , worst movie ever seen ..."

-- from http://www.imdb.com/title/tt0468569/
local str = [[
Batman has always been my favourite superhero ever since the first time I heard about him because he his human with no powers, also he is much more questionable than any other superhero. The story of the film is about Batman, Lieutenant James Gordon, and new district attorney Harvey Dent beginning to succeed in rounding up the criminals that plague Gotham City. They are unexpectedly challenged when a mysterious criminal mastermind known as the Joker appears in Gotham. Batman's struggle against the Joker becomes deeply personal, forcing him to "confront everything he believes" and to improve his technology (which introduces the recreation of the Batcycle, known as the Batpod and the Batsuit was redesigned) to stop the madman's campaign of destruction. During the course of the film, a love triangle develops between Bruce Wayne, Dent and Rachel Dawes.

There are now six Batman films and I must say that The Dark Knight is the best out of all of them. The title is good because that is what Batman actually is. It has been 3 years for the adventure to continue from Batman Begins but that entire wait was worth it. Gotham city is very Gothic looking and is very haunting and visionary. The whole movie is charged with pulse-pounding suspense, ingenious special effects and riveting performances from a first-rate cast especially from Heath Ledger who gave an Oscar nomination performance for best supporting-actor. It is a shame that he can't see his terrific work on-screen. The cinematography is excellent which is made so dark & sinister that really did suit the mood for the film. Usually sequels don't turn out to be better than the original but The Dark Knight is one of those rare sequels that surpasses the original like The Godfather 2. I also really liked the poster where the building is on fire in a Bat symbol & Batman is standing in front of it. Christopher Nolan is a brilliant director and his film Memento is one of my most favourite films. He hasn't made 10 movies yet and 3 of them are already on the IMDb top 250. Overall The Dark Knight is the kind of movie that will make the audience cheer in the end instead of throwing fruit & vegetables on the screen.
]]

-- from http://www.imdb.com/title/tt1333125/?ref_=fn_al_tt_1
--local str = [[
--Omg, I'm very open person but for the first time I went out of a movie after 30minutes. Feeling sick. We didn't know what to do with ourselves. Went to a shop to buy anything and everything to reset our brains. :) I just made an account here, only to express that it is simply not fair! I feel cheated. How people can lie so much in the description of the movie. I can't believe those actors took part in it. What a shame. Why? Why! This is only for people who laughs at obscenities and profanity. And defecation. But if you surprisingly don't, it's not funny at all. I was waiting for any story behind it but.. no. There was nothing there.
--
--Wait for a DVD or sth if all those negative reviews made you interested. Really don't pay for the cinema ticket. Really.
--]]

require'eval_str'.main(str, {
    fnModel = 'cv/model_dft.t7',
    fnVocab = 'cv/vocab_dft.t7'
})
