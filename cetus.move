module flashloan::cetus_pool{
    use std::string::{Self, String};
    use cetus_clmm_test::pool_creator::{create_pool_v2_by_creation_cap as cetus_pool_create};

    public fun test_create_pool(){
    cetus_pool_create()
    }

}
