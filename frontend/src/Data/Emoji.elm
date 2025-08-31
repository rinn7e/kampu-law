module Data.Emoji exposing (..)


type alias Subject =
    { selected : Bool, code : String, label : String }


subjects : List Subject
subjects =
    [ { selected = False, code = "🇰🇭", label = "ជាតិ" } -- the country
    , { selected = False, code = "☸️", label = "សាសនា" } -- religion
    , { selected = False, code = "👑", label = "ក្សត្រ" } -- king
    , { selected = False, code = "🏛️", label = "រដ្ឋសភា" } -- national assembly
    , { selected = False, code = "⚖️", label = "ព្រឹទ្ធសភា" } -- senate
    , { selected = False, code = "👔", label = "នាយករដ្ឋមន្ត្រី" } -- prime minister
    , { selected = False, code = "\u{1FA96}", label = "យោធា" } -- army
    , { selected = False, code = "🌏", label = "ការទូត" } -- foreign stuff
    , { selected = False, code = "👥", label = "ប្រជាជន" } -- normal citizen
    , { selected = False, code = "🏢", label = "សមូហភាព" } -- សមូហភាព / entity

    -- , { code = "🚧", label = "x" } -- wip
    ]


type alias Topic =
    String


topics =
    [ "🕊️" -- freedom
    , "🗣️" -- freedom of speach
    , "🗳️" -- voting
    , "👸" -- queen
    , "🚹" -- male
    , "🚺" -- female
    , "🚼" -- minor (under 18)
    , "📢" -- protest
    , "⛓️" -- imprisonment
    , "📜" -- sue
    , "🔑" -- personal possession
    , "🚔" -- unlawful act / crime
    , "💵" -- economy / trade
    , "☢️" -- bioharzard
    ]
