DATA_species = {
    :species_keys =>
        ["name", "code"],
    :species => [
        ["Sharp-shinned Hawk", "SSHA"],
        ["Yellow-billed Cuckoo", "YBCU"],
        ["Black-billed Cuckoo", "BBCU"],
        ["Ruby-throated Hummingbird", "RTHU"],
        ["Red-bellied Woodpecker", "RBWO"],
        ["Downy Woodpecker", "DOWO"],
        ["Hairy Woodpecker", "HAWO"],
        ["Eastern Wood-Pewee", "EAWP"],
        ["Yellow-bellied Flycatcher", "YBFL"],
        ["Acadian Flycatcher", "ACFL"],
        ["Traill's Flycatcher", "TRFL"],
        ["Least Flycatcher", "LEFL"],
        ["Eastern Phoebe", "EAPH"],
        ["Great Crested Flycatcher", "GCFL"],
        ["Eastern Kingbird", "EAKI"],
        ["Blue-headed Vireo", "BHVI"],
        ["Warbling Vireo", "WAVI"],
        ["Philadelphia Vireo", "PHVI"],
        ["Red-eyed Vireo", "REVI"],
        ["Blue Jay", "BLJA"],
        ["Tree Swallow", "TRES"],
        ["Barn Swallow", "BARS"],
        ["Black-capped Chickadee", "BCCH"],
        ["Red-breasted Nuthatch", "RBNU"],
        ["White-breasted Nuthatch", "WBNU"],
        ["Carolina Wren", "CARW"],
        ["House Wren", "HOWR"],
        ["Blue-gray Gnatcatcher", "BGGN"],
        ["Ruby-crowned Kinglet", "RCKI"],
        ["Veery", "VEER"],
        ["Gray-cheeked Thrush", "GCTH"],
        ["Swainson's Thrush", "SWTH"],
        ["Hermit Thrush", "HETH"],
        ["Wood Thrush", "WOTH"],
        ["American Robin", "AMRO"],
        ["Gray Catbird", "GRCA"],
        ["Brown Thrasher", "BRTH"],
        ["Cedar Waxwing", "CEDW"],
        ["Ovenbird", "OVEN"],
        ["Worm-eating Warbler", "WEWA"],
        ["Northern Waterthrush", "NOWA"],
        ["Blue-winged Warbler", "BWWA"],
        ["Black-and-white Warbler", "BAWW"],
        ["Prothonotary Warbler", "PROW"],
        ["Tennessee Warbler", "TEWA"],
        ["Orange-crowned Warbler", "OCWA"],
        ["Nashville Warbler", "NAWA"],
        ["Connecticut Warbler", "CONW"],
        ["Mourning Warbler", "MOWA"],
        ["Kentucky Warbler", "KEWA"],
        ["Common Yellowthroat", "COYE"],
        ["Hooded Warbler", "HOWA"],
        ["American Redstart", "AMRE"],
        ["Cape May Warbler", "CMWA"],
        ["Cerulean Warbler", "CERW"],
        ["Northern Parula", "NOPA"],
        ["Magnolia Warbler", "MAWA"],
        ["Bay-breasted Warbler", "BBWA"],
        ["Blackburnian Warbler", "BLBW"],
        ["Yellow Warbler", "YEWA"],
        ["Chestnut-sided Warbler", "CSWA"],
        ["Blackpoll Warbler", "BLPW"],
        ["Black-throated Blue Warbler", "BTBW"],
        ["Yellow Palm Warbler", "YPWA"],
        ["Pine Warbler", "PIWA"],
        ["Yellow-rumped Warbler", "MYWA"],
        ["Yellow-throated Warbler", "YTWA"],
        ["Prairie Warbler", "PRAW"],
        ["Black-throated Green Warbler", "BTNW"],
        ["Canada Warbler", "CAWA"],
        ["Wilson's Warbler", "WIWA"],
        ["Yellow-breasted Chat", "YBCH"],
        ["Eastern Towhee", "EATO"],
        ["Chipping Sparrow", "CHSP"],
        ["Field Sparrow", "FISP"],
        ["Savannah Sparrow", "SAVS"],
        ["Nelson's Sparrow", "NESP"],
        ["Seaside Sparrow", "SESP"],
        ["Song Sparrow", "SOSP"],
        ["Lincoln's Sparrow", "LISP"],
        ["Swamp Sparrow", "SWSP"],
        ["White-throated Sparrow", "WTSP"],
        ["White-crowned Sparrow", "WCSP"],
        ["Dark-eyed Junco", "SCJU"],
        ["Summer Tanager", "SUTA"],
        ["Scarlet Tanager", "SCTA"],
        ["Northern Cardinal", "NOCA"],
        ["Rose-breasted Grosbeak", "RBGR"],
        ["Indigo Bunting", "INBU"],
        ["Red-winged Blackbird", "RWBL"],
        ["Common Grackle", "COGR"],
        ["Brown-headed Cowbird", "BHCO"],
        ["Orchard Oriole", "OROR"],
        ["Baltimore Oriole", "BAOR"],
        ["Purple Finch", "PUFI"],
        ["American Goldfinch", "AMGO"]
    ]
}

def make_species
    DATA_species[:species].each do |species|
        new_species = Species.new
        species.each_with_index do |attribute, i|
            new_species.send(DATA_species[:species_keys][i]+"=", attribute)
        end
        new_species.save
    end
end


DATA_banders = {
    :bander_keys =>
      ["name", "password"],
    :banders => [
    ['Sara', 'password'],
    ['Andy', 'password'],
    ['Anthony', 'password'],
    ['Becky', 'password'],
    ['David', 'password'],
    ['Kristen', 'password'],
    ['Liz', 'password'],
    ['Mary', 'password'],
    ['Peg', 'password']
    ]
}

def make_banders
    DATA_banders[:banders].each do |bander|
        new_bander = Bander.new
        bander.each_with_index do |attribute, i|
            new_bander.send(DATA_banders[:bander_keys][i]+"=", attribute)
        end
        new_bander.save
    end
end

def main
    make_species
    make_banders
end

main