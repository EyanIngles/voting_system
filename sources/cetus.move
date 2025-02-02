module flashloan::cetus_pool{
    use std::string::{Self, String};
    use sui::coin::{Coin, CoinMetadata};
    use sui::clock::Clock;
    use sui::tx_context::TxContext;

    use cetus_clmm_test::pool_creator::{create_pool_v2 as cetus_pool_create};
    use cetus_clmm_test::config::{GlobalConfig as Config}; // globalConfig is created from cetus and it required us to pass the object id through.
    use cetus_clmm::factory::{Pools, InitFactoryEvent};

    public fun test_create_pool<T0, T1>(
    pools: &mut Pools,
    config: &GlobalConfig
    tick_spacing: u32,
    initialize_price: u128,
    url: 0x1::string::String,
    tick_lower_idx: u32,
    tick_upper_idx: u32,
    coin_metadata_a: Coin<T0>,
    coin_metadata_b: Coin<T1>,
    amount_coin_a: u64,
    amount_coin_b: u64,
    fix_amount_a: bool,
    clock: &Clock,
    ctx: &mut TxContext){
    const pool = test_create_new_pool();
    cetus_pool_create(
        config,

        )}

    fun test_create_new_pool():&mut Pool {
        let pools = Pools {
        id: sui::object::new(ctx),
        list: move_stl::linked_table::new(ctx),
        index: 0
    };
    }

}
