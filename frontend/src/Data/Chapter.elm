module Data.Chapter exposing (..)


type alias Chapter =
    { index : Int
    , name : String
    , description : Maybe String
    , isNew : Bool
    }


chapters =
    [ { index = 1
      , name = "អំពីអធិបតេយ្យ"
      , description = Nothing
      , isNew = False
      }
    , { index = 2
      , name = "អំពីព្រះមហាក្សត្រ"
      , description = Nothing
      , isNew = False
      }
    , { index = 4
      , name = "អំពីរបបនយោបាយ"
      , description = Nothing
      , isNew = False
      }
    , { index = 5
      , name = "អំពីសេដ្ឋកិច្ច"
      , description = Nothing
      , isNew = False
      }
    , { index = 6
      , name = "អំពីអប់រំ វប្បធម៌ និងសង្គមកិច្ច"
      , description = Nothing
      , isNew = False
      }
    , { index = 7
      , name = "អំពីរដ្ឋសភា"
      , description = Nothing
      , isNew = False
      }
    , { index = 8
      , name = "អំពីព្រឹទ្ធសភា"
      , description = Nothing
      , isNew = True
      }
    , { index = 9
      , name = "អំពីសមាជរដ្ឋសភា និងព្រឹទ្ធសភា"
      , description = Nothing
      , isNew = True
      }
    , { index = 10
      , name = "អំពីរាជរដ្ឋាភិបាល"
      , description = Nothing
      , isNew = True
      }
    , { index = 11
      , name = "អំពីអំណាចតុលាការ"
      , description = Nothing
      , isNew = True
      }
    , { index = 12
      , name = "អំពីក្រុមប្រឹក្សាធម្មនុញ្ញ"
      , description = Nothing
      , isNew = True
      }
    , { index = 13
      , name = "អំពីការគ្រប់គ្រងរដ្ឋបាល"
      , description = Nothing
      , isNew = True
      }
    , { index = 14
      , name = "អំពីសមាជជាតិ"
      , description = Nothing
      , isNew = True
      }
    , { index = 15
      , name = "អំពីអង្គការរៀបចំការបោះឆ្នោត"
      , description = Nothing
      , isNew = True
      }
    ]
