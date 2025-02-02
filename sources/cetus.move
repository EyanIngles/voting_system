module flashloan::cetus_pool{
    use std::string::{Self, String};
    use sui::coin::{Coin, CoinMetadata};
    use sui::clock::Clock;
    use sui::tx_context::TxContext;

    use cetus_clmm_test::pool_creator::{create_pool_v2 as cetus_pool_create};
    use cetus_clmm_test::config::{GlobalConfig as Config};
    use cetus_clmm::factory::{Pools, InitFactoryEvent};

    public fun test_create_pool<T0, T1>(){
    const pool = test_create_new_pool();
    cetus_pool_create(
        _config: &GlobalConfig,
        )}

    fun test_create_new_pool():&mut Pool {
        let pools = Pools {
        id: sui::object::new(ctx),
        list: move_stl::linked_table::new(ctx),
        index: 0
    };
    }

}
