
<map>
  <node ID="root" TEXT="PNC处理一览 副本">
    <node TEXT="10ms的定时器处理" ID="1b898c1bfa2321656539f52a2b6fc3d7" STYLE="bubble" POSITION="right">
      <node TEXT="周期100ms" ID="02948919722c0a37f5eb5ce711dbb50b" STYLE="fork"/>
      <node TEXT="信息更新" ID="4dfe9b31931be4c2d5a0fc46f880e208" STYLE="fork">
        <node TEXT="更新自车的状态信息" ID="69b7688c2d447e27a8105eb8a41a014c" STYLE="fork">
          <node TEXT="如果0.5s未更新，则退出自动驾驶" ID="cec79f03881cea7ef8f773298eb67408" STYLE="fork"/>
        </node>
        <node TEXT="更新obs的信息" ID="7746470ea89edf747d21856610370f43" STYLE="fork">
          <node TEXT="如果0.5s未更新，则认为Perception Topic Loss" ID="a64dddbf7a6db93c5856e0a8722fae53" STYLE="fork"/>
        </node>
        <node TEXT="更新grid_map" ID="ef3abdb7023276f89d2673bccd50894e" STYLE="fork"/>
        <node TEXT="从world model获取static map​static_map.proto​" ID="9064d1f62c506ba8a031291caefcc023" STYLE="fork">
          <node TEXT="更新RoadMap" ID="519012ac32af9ebd6b97f6eb9a422925" STYLE="fork"/>
          <node TEXT="更新NaviMap" ID="81921bdfe31b1ad72b4507088b4d5cc6" STYLE="fork"/>
        </node>
        <node TEXT="从world model获取dynamic map​Local Map接口方案​" ID="43d869bd18268d4fbca3fff98ea6b379" STYLE="fork">
          <node TEXT="更新dynamic map" ID="e44567a768ab7b6a8573492ccb1ad06a" STYLE="fork"/>
        </node>
        <node TEXT="更新交通拥堵信息（traffic_info）" ID="d56c115b43b20e710ca287fd3678d3e8" STYLE="fork"/>
        <node TEXT="如果和上次规划间隔大于0.5s，则清除历史规划信息" ID="53a1aa249989a2ead58730b308c58d4f" STYLE="fork"/>
      </node>
      <node TEXT="变道逻辑处理" ID="3ecae08d6332433e3e5eef8c16e73706" STYLE="fork">
        <node TEXT="变道冷却" ID="84d901839d9880f78681b005ecef70ba" STYLE="fork">
          <node TEXT="对于合流、分流、下匝道、匝道到主路，不需要变道冷却" ID="82824b680e8945e2f111bd4d66c6d6f1" STYLE="fork"/>
          <node TEXT="对于自车道前车慢车、风险OBS、静止车辆等，需要变道冷却" ID="35d4db7c567dea468700c6019e774967" STYLE="fork">
            <node TEXT="重复触发变道的冷却时间3s" ID="5b7381c79e321540c8d92d05bc2986b4" STYLE="fork"/>
            <node TEXT="用户未确认，冷却15s" ID="bb075d3fa04f276e1f0ce806834bc5d4" STYLE="fork"/>
            <node TEXT="上次变道间隔，冷却2s" ID="fa2509b8cf1e176c73b71f2e627ca2da" STYLE="fork"/>
            <node TEXT="导航变道，冷却10s" ID="5a938f3f677c57bb85936f69de2a56b1" STYLE="fork"/>
            <node TEXT="超车/优选/避免汇入 变道，冷却时间：20s" ID="89a1ca9a5f4b3a2fbbcf8c0799ec3f28" STYLE="fork"/>
          </node>
          <node TEXT="用户变道拒绝计数清零" ID="684b693a81e982d0e5a92d994d432406" STYLE="fork">
            <node TEXT="累计距离超过600m" ID="57c8c63c0c49abbb7db2f92cda714f4d" STYLE="fork"/>
            <node TEXT="距上次的拨杆确认和拨杆未确认超时超过30s" ID="5a4f4897ba3b4cb75921d8486a0a658e" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="ALC用户确认模式" ID="6488cafb5054469a56b42d5908afb7f2" STYLE="fork">
          <node TEXT="若route的变道请求无效或者变道类型（LEFT_FORWARD，RIGHT_FORWARD）不连续，则reset变道确认" ID="6bc384b30e88fad72c71e14af349b49d" STYLE="fork"/>
          <node TEXT="变道过程中或非ALC用户确认模式，不提示确认" ID="95aa936ab4e8d1ea60740ddc2fbbeaf4" STYLE="fork"/>
          <node TEXT="获取拨杆变化状态" ID="68c9b684e2996e295a1dd8995897cde9" STYLE="fork">
            <node TEXT="不是拨杆回正" ID="c6a078773bf5d159d937c1d523b7cb71" STYLE="fork"/>
            <node TEXT="转向灯或拨杆的方向和上次不一样" ID="d3d13232ac863fe15f51ada76a1c742e" STYLE="fork"/>
          </node>
          <node TEXT="用户轻拨拨杆和变道请求方向一致，则完成变道确认，否则变道拒绝" ID="82170e42fb5c543349362db67e3bd6b5" STYLE="fork"/>
          <node TEXT="用户未拨杆确认，且超过15s，则变道拒绝" ID="489ac1c09274a131f79f0687c0fdb5cb" STYLE="fork"/>
        </node>
        <node TEXT="变道状态切换参考​PNC架构​“变道状态切换”" ID="7db8ae75b50d4219745e72fee847df6b" STYLE="fork">
          <node TEXT="对于split点小于50m，更新变道状态（LEFT/RIGHT）" ID="76b611906b62d28ce2f102acb211bcff" STYLE="fork"/>
          <node TEXT="在cancel事件状态，且自车变道类型为LEFT/RIGHT，则不能cancel，继续变道" ID="53e1e29534ad0302de315574a82da9b0" STYLE="fork"/>
        </node>
      </node>
      <node TEXT="更新输入" ID="1a07da1aeeb7243dd9eebefefaea9005" STYLE="fork">
        <node TEXT="更新LaneMap（使用dynamic map）" ID="1af1346b0702247bb5cb0938a1b285db" STYLE="fork">
          <node TEXT="若dynamic map的中心线/形点为空/长度大于3km，则无效" ID="e42cb1aed8e13ca73d87e081e576bcd4" STYLE="fork"/>
          <node TEXT="更新RoadMap信息（使用SD更新HD的road class，form way）" ID="dc28f42580fb28f7cdadea255aa21319" STYLE="fork"/>
        </node>
        <node TEXT="HDMap是否可用" ID="c7b7ff8e790509c2c472d1cf86afa332" STYLE="fork">
          <node TEXT="当前的hd map是否有效" ID="600a1145b5e1b46da9701f2a5ea365e7" STYLE="fork"/>
          <node TEXT="hd定位是否有效（confidence=0为无效）" ID="078c274a90116db2393955e5a9ecad30" STYLE="fork"/>
          <node TEXT="进入lane seg区域" ID="0c30133d59f0a4d47ebfa592df148f3b" STYLE="fork"/>
        </node>
        <node TEXT="更新位姿Transformation" ID="79ab34c1c6a6d8f98eea241d678cd612" STYLE="fork">
          <node TEXT="根据自车位姿和时间做插值" ID="dafaab3c1476b58464290d7729b540f3" STYLE="fork"/>
          <node TEXT="获取上次的地图坐标转换为最新的地图坐标的delta_map_transformation" ID="e63a9f7dd037540b05dd8a3255b2a2be" STYLE="fork"/>
          <node TEXT="获取上帧和当前位姿的transformation，并对上次规划的path转换" ID="0046466deba11a3e3c2e20af4b150832" STYLE="fork"/>
        </node>
        <node TEXT="更新感知OBJ信息" ID="b1d5b708dab0470db8e848c9c862e86a" STYLE="fork">
          <node TEXT="计算OBJ在map上的位姿信息" ID="42a1efef9e723e39a14667fcf1a7a83a" STYLE="fork">
            <node TEXT="obj 2 map = map 2 car的逆*obj 2 car" ID="541bcb0bc9c6a2425064c9eb21c9a2e1" STYLE="fork"/>
          </node>
          <node TEXT="delta heading = obj_heading - ego_heading" ID="728bf1006f3aaa3a7e5d872095ea8e5f" STYLE="fork"/>
          <node TEXT="按照delta_heading分解[cos(delta), - sin(delta); sin(delta), cos(delta)]更新vx, vy, ax, ay" ID="ebffaafc6495d7d156efd91e507fd28c" STYLE="fork"/>
          <node TEXT="更新轮廓点polygon" ID="dac6f9e8fafb002733d9148c68fe66fb" STYLE="fork"/>
        </node>
        <node TEXT="更新xxx" ID="6cef2d3357ce1b11b83c577f072e43ca" STYLE="fork">
          <node TEXT="根据dynamic map的时间插值得到dynamic_map_2_car_pos" ID="b08401a74a03ccf0c0d4ce2b6f229e09" STYLE="fork"/>
          <node TEXT="hd_map_2_dynamic_map = map 2 car的逆*dynamic_map_2_car_pos" ID="c51e0659c591c3e98e1eaa808b07bbdb" STYLE="fork"/>
        </node>
      </node>
      <node TEXT="若local road map更新或距离(自车当前位置距离上次的位置)超过50m，则需要更新local map" ID="3fe0361c639714ccba192c515817b260" STYLE="fork"/>
      <node TEXT="更新" ID="927cc904e36b5c28383ed429f024a05f" STYLE="fork">
        <node TEXT="更新全局路由" ID="0ef05010862b0910a94d267fe36df58f" STYLE="fork">
          <node TEXT="更新subtask，subtask参见​Avp Routing设计文档​" ID="77d2d9f1c1b630e015da103e729d6bfa" STYLE="fork"/>
          <node TEXT="生成并发布routing request info" ID="4702b9eebd0c5a049953e419e476d273" STYLE="fork">
            <node TEXT="PSP到定位框" ID="469b6470ce15ef0a0ca3fe038dd17629" STYLE="fork"/>
            <node TEXT="PSP到排队区" ID="84b838625914e568ca596914d531a172" STYLE="fork"/>
            <node TEXT="其他no avp routing" ID="818f446178fcd00450762b6e99c7946c" STYLE="fork"/>
          </node>
          <node TEXT="更新navi info" ID="93ed0b3a1da694e73f75efea16d3ce57" STYLE="fork">
            <node TEXT="根据自车位置在local road map中找到所在的lane（根据heading和距离找）" ID="ce7cc9a08fd84209fef8ba67eb90c095" STYLE="fork"/>
            <node TEXT="根据lane找所有的hd link segments" ID="28f4513c844848a6b049d2f97a8bd8ff" STYLE="fork"/>
            <node TEXT="获取当前自车位置的sl坐标s, l" ID="42298dcd2640411c2f102d994333fe7d" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="更新RoadMap和routing信息" ID="c284e7bbba54f25afaae46746c31250a" STYLE="fork">
          <node TEXT="check全局路由" ID="886cb87c7878ea482656184923bc44b5" STYLE="fork">
            <node TEXT="当前车道（车道级定位）的boundary为虚拟线时，不做check" ID="efd57bba0339fe11328160260955a3dc" STYLE="fork"/>
            <node TEXT="在OOL_Nudge（Start/Nudging/Cancel）中，不做check" ID="83463974eecbaee5dacfd32995e48f39" STYLE="fork"/>
            <node TEXT="判断全局路由是否包含当前车道id" ID="eca9434dece91a4b661c3d7c1f67ad73" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="根据当前车道id获取road class" ID="1f80a7a20501fd6f18b8cfdb2de32c66" STYLE="fork"/>
        <node TEXT="获取上帧和当前位姿的transformation，并对上次规划的path转换" ID="5a6ba34c20a9d0d0f0de8fabcb4140d2" STYLE="fork"/>
        <node TEXT="计算stitch path" ID="98a86c7947b9a0a884c2ae9e3b3eb776" STYLE="fork">
          <node TEXT="重规划初始化" ID="451206065a15a2b2c2ef8dda93061027" STYLE="fork">
            <node TEXT="基于当前位姿计算轨迹点（x, y, z, theta, speed, acc, curvature=front_wheel_angle/wheel_base）" ID="47b3032b4e3558505245b5e01328bb06" STYLE="fork"/>
          </node>
          <node TEXT="往前重规划" ID="e457690e876aa98faaa107e60b268181" STYLE="fork">
            <node TEXT="找规划轨迹中距离最近的轨迹点和上次规划轨迹的时间最近的轨迹点索引最小" ID="f090234c69be5a087f6085ac48eabe4a" STYLE="fork"/>
            <node TEXT="找stitch point（相对时间+150ms），从最小索引点到stitch point，依次加入轨迹点，并更新time（每个点的时间-相对时间）和speed（max(0, 每个点的speed)）" ID="e00d9f58e81ec35e1ea1970f5771eeb2" STYLE="fork"/>
          </node>
          <node TEXT="如果功能未激活或上次规划轨迹为空，则横纵向重规划，并进行重规划初始化" ID="b7277999081fa5f47ecf161f1a3c0a86" STYLE="fork"/>
          <node TEXT="按照相对时间（当前时间-上次规划轨迹的meas_time）找到最近的轨迹点" ID="0195413c0c5cea87d3d40e38e30c6293" STYLE="fork">
            <node TEXT="若该点无效或者为不在轨迹范围内，则横纵向重规划，并进行重规划初始化" ID="df0883ed2fd7983be31b341c125bf912" STYLE="fork"/>
          </node>
          <node TEXT="按照当前位置在上次规划轨迹中找到最近的轨迹点" ID="b7a4850d03dcdab303a0588834e44e3c" STYLE="fork">
            <node TEXT="若该点无效，则横纵向重规划，并进行重规划初始化" ID="64ac3f3aeee95c0a0b54070d55960551" STYLE="fork"/>
            <node TEXT="按照当前位置计算上次规划轨迹中最近的轨迹点的frenet（s, d）" ID="cdf06816f4054628c84365ce9104edcb" STYLE="fork"/>
            <node TEXT="若d &gt; 0.5m，则横纵向重规划，并进行重规划初始化" ID="69bdfdd9d3fbb2552ad5241d7c1ca113" STYLE="fork"/>
          </node>
          <node TEXT="上次规划轨迹中距离最近的轨迹点的s和上次规划轨迹的时间最近的轨迹点的s相差5m，则纵向重规划，并进行往前重规划" ID="1dfb3b579a15c7df24cee9fa858da808" STYLE="fork"/>
          <node TEXT="更新停止状态，详见​PNC架构​重规划的StopState切换" ID="041f557a55f3cab350a3ce942802a1a7" STYLE="fork">
            <node TEXT="当前停止状态处于Stopped状态，则横纵向重规划，并进行重规划初始化" ID="d8fd41388c107fe83ac19cf19f44f1eb" STYLE="fork"/>
            <node TEXT="当前停止状态处于StartUp状态，且上次规划轨迹中距离最近的轨迹点的s和上次规划轨迹的时间最近的轨迹点的s相差1m或速度变化超过1m/s，则横纵向重规划，并进行重规划初始化" ID="f1747c88375c3c38e710244490e7f0d4" STYLE="fork"/>
          </node>
          <node TEXT="override" ID="addbe20ea2f88f4b579db59609a7596d" STYLE="fork">
            <node TEXT="纵向override，则纵向重规划，并进行往前重规划" ID="5ed1f81ecbec505ec7f3938db42f1d5a" STYLE="fork"/>
            <node TEXT="横向override，则横向重规划，并进行往前重规划" ID="86ef00d4193f5d89788166ffacd81ee3" STYLE="fork"/>
            <node TEXT="横纵向override，则横纵向重规划，并进行重规划初始化" ID="a5dab5100f0cda8670c55b2cbbc6182b" STYLE="fork"/>
          </node>
          <node TEXT="其他，则不做重规划，并进行往前重规划" ID="233db80f2e1fe9584b38eb43c8c4d1b5" STYLE="fork"/>
        </node>
        <node TEXT="刷新规划的init point" ID="867e0297fb7fb6424304ea2d816165d9" STYLE="fork">
          <node TEXT="纵向重规划，则用当前的车速、加速度更新stitch point，并将其time归0" ID="fe54d80a95cb881248a2c9ee0aa881a9" STYLE="fork"/>
          <node TEXT="横向重规划，则用当前的自车信息（位姿，k, s, l, dl, dll）更新stitch point" ID="6e13d88d3aa70f7596895d378bc4e84b" STYLE="fork"/>
        </node>
        <node TEXT="local route的更新策略" ID="35f3bec00e51f9321020026781799817" STYLE="fork">
          <node TEXT="抑制local router的更新" ID="9edda1304c1c2624f8db4b565e542026" STYLE="fork">
            <node TEXT="当前处于变道状态或开始nudge或正在nudge或取消nudge" ID="d3f53e8e4bbe0738c65bcea98e109a5e" STYLE="fork"/>
          </node>
          <node TEXT="开始变道" ID="a9dc16e02ecc89bc9b5233624b859c35" STYLE="fork">
            <node TEXT="左变道" ID="cc82b3f26090fd650f429310c7c953b4" STYLE="fork">
              <node TEXT="当前local router为参考线的左车道router" ID="d58fab8391540a49387ef5a6e907dc3e" STYLE="fork"/>
            </node>
            <node TEXT="右变道" ID="cbc6eefbdc1ea612615b7ded3952f1aa" STYLE="fork">
              <node TEXT="当前local router为参考线的右车道router" ID="8fa0ac27a5fc5c63c3f865144d876096" STYLE="fork"/>
            </node>
            <node TEXT="其他" ID="1efff4344ce7aaad23d8593d7ef28fe5" STYLE="fork">
              <node TEXT="当前local router为参考线的当前车道router" ID="a2f6934f2faec7a9ae06c71b47229446" STYLE="fork"/>
            </node>
          </node>
        </node>
        <node TEXT="更新local route" ID="06f1cb3ac455bbbb5a594c3a1b15f703" STYLE="fork">
          <node TEXT="按照delta_map_transformation更新local route点" ID="afd8b129ff38f3635058c03e79604423" STYLE="fork"/>
          <node TEXT="刷新本地路由策略" ID="19b27349d8e2913abc0390f4a4315b6a" STYLE="fork">
            <node TEXT="road map的地图来源不变" ID="9b3af0dae05b12947d064c186f4647c1" STYLE="fork"/>
            <node TEXT="road map的地图来源变化" ID="fc780ee041823974c49d4a54d5a7effe" STYLE="fork">
              <node TEXT="构建local route" ID="394455da5b52bb8cf6001d6b1d3f877a" STYLE="fork">
                <node TEXT="遍历lane segments" ID="fd7b7cf9d96bfb201bd2f5934fc151da" STYLE="fork">
                  <node TEXT="将lane的中心线上的点，按序加入（&gt;0.1m）" ID="b29a20cb52f4004ca01bf766e340e8dc" STYLE="fork"/>
                  <node TEXT="若lane的overlap为停止线，将overlap id加入stop line-&gt;lane及overlap set中" ID="3c0a6ff8139d53c9e3379a469db177b9" STYLE="fork"/>
                  <node TEXT="若lane的overlap为停止线，将overlap id加入lane-&gt;stop line及overlap set中" ID="d471b88deb70dca8a7096effffffab1f" STYLE="fork"/>
                  <node TEXT="若lane的overlap为junction（路口），加入junction_map及overlap set中" ID="a391b52b114f3aa106a1b276ebd2b1e2" STYLE="fork"/>
                  <node TEXT="对overlap set按s进行从小到大排序，并针对各个类别加入不同的集合" ID="2f87759202db1989aafae6c1064905d7" STYLE="fork">
                    <node TEXT="禁停区" ID="8dc49cfca84fdc07bf9036cd375b2648" STYLE="fork"/>
                    <node TEXT="人行横道" ID="17643e34cf67fd4204d08212b92e3b8d" STYLE="fork"/>
                    <node TEXT="路口" ID="20b3d53e1c6649b50cc07663e1a05009" STYLE="fork"/>
                    <node TEXT="车道线" ID="6bc3cd38b0cbccc27ce93a0481b5ad16" STYLE="fork"/>
                    <node TEXT="停止线" ID="fa844c3d0fceae3f030edc978723dff1" STYLE="fork"/>
                    <node TEXT="减速带" ID="dec43552e91a5cf5f652e57de7625f57" STYLE="fork"/>
                  </node>
                  <node TEXT="根据lane上的三个中心点，计算曲率" ID="9b1dc097dc44b274e1f946bda786340b" STYLE="fork"/>
                  <node TEXT="更新merge/split点的信息" ID="f3efaeae5bab34efbdc242d458586a0d" STYLE="fork">
                    <node TEXT="根据lane的拓扑关系，前驱有多个后继，则为split，后继有多个前驱，则为merge" ID="554ab9d58cd5021b3dea9f4c9e8b02ef" STYLE="fork"/>
                  </node>
                  <node TEXT="根据merge/split点信息计算MergeSplitRegion" ID="671f85f94c458559c66f8aa467b9f30f" STYLE="fork">
                    <node TEXT="根据左/右侧的车道线类型，若为虚拟线或者虚拟辅助线，则增加到width_extended_region" ID="b7877fc1d1e6b2a15458e0f83704a761" STYLE="fork"/>
                  </node>
                </node>
              </node>
              <node TEXT="lane是否在routing上有效" ID="94857a2a2d3dd5ac5d3fef46076f52e8" STYLE="fork">
                <node TEXT="在全局路由上" ID="fd4c4cd7550a38f25074df186f8b39d1" STYLE="fork"/>
                <node TEXT="在全局路由的后继上" ID="1adec3ce7c68fa39e35fc4694d3c04d6" STYLE="fork"/>
                <node TEXT="非无效类型：路肩，公交车道，公交停靠站车道，非驾驶区域（禁停区），潮汐车道，收费车道，应急车道" ID="837292de521acd2ba2fc0af7bc846e6a" STYLE="fork"/>
              </node>
              <node TEXT="找到lanes上最近的way point信息" ID="c1092873a3e4a81789c4383668b76b4f" STYLE="fork">
                <node TEXT="遍历有效lanes" ID="f7f818630901eb409a75391873847985" STYLE="fork">
                  <node TEXT="将init point带heading投影到lanes上，计算s, l, distance" ID="c2755f3abf44c945113d1907303202a7" STYLE="fork"/>
                  <node TEXT="若投影点超过lanes的有效长度，则忽略" ID="f44ebbd173df4cdbd0a366ac259efdf3" STYLE="fork"/>
                  <node TEXT="计算和投影点distance最小的way point（lane, s, l, heading, position）" ID="3f5b00e7dcef4182db4b8c99ac004a59" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="根据way point生成本地路由" ID="70134be52b24db4829ffcf6d8ba987c1" STYLE="fork">
                <node TEXT="通过way point的lane向后找50m以内的前驱lane segment（要在local road map或者全局路由上）" ID="b131a3729609a2029fd20869666c7349" STYLE="fork"/>
                <node TEXT="check way point所在的lane是否在routing上有效" ID="61d7868013a1b17338b39d0ffc015589" STYLE="fork"/>
                <node TEXT="DFS遍历way point的lane的后继，直至达到规划距离或无后继，得到lane segments及其local routes" ID="b16dfe5b8f9d40aad844f87750c2241d" STYLE="fork">
                  <node TEXT="构建local route" ID="ffc37fd8499f7c2681bd5991258f9970" STYLE="fork"/>
                </node>
                <node TEXT="遍历local routes" ID="a10a0d74ae0ab12615dba4404929a430" STYLE="fork">
                  <node TEXT="遍历route" ID="118481d787c48e17a185a34891fca304" STYLE="fork">
                    <node TEXT="扩展左车道的local routes" ID="6145808f1e25162f6a03974f1fa6f31b" STYLE="fork">
                      <node TEXT="遍历routes的lane segments" ID="20f4f5783dd4a58c69a43771d4ac4456" STYLE="fork">
                        <node TEXT="check左车道是否在routing上有效，无效则忽略" ID="c0bca9bf6650a49a6142516a219f112a" STYLE="fork"/>
                        <node TEXT="左车道的前驱作为back lane，前驱有多个后继，则为split" ID="b3c5f057156e3824cea2dd2ee32875cc" STYLE="fork">
                          <node TEXT="做DFS遍历back lane的后继，直至达到规划距离或无后继，得到lane segments及其local routes" ID="1cf382a081ccbc70832119c10f1e2222" STYLE="fork"/>
                          <node TEXT="local routes作为left branch" ID="468dca306af487c01bc0dfa0bc600caf" STYLE="fork"/>
                        </node>
                      </node>
                    </node>
                    <node TEXT="同样扩展右车道的local routes" ID="cafef750d7254d472b1ac23141a922e4" STYLE="fork"/>
                  </node>
                </node>
              </node>
              <node TEXT="根据用户set speed计算分段限速" ID="3f9fe5b4c8041617c7667ee13076e396" STYLE="fork">
                <node TEXT="当前local route计算限速值" ID="a6829d52e1a3c45fb1057952b7143032" STYLE="fork">
                  <node TEXT="将用户set speed作为初段的限速值" ID="fb1334aa0dc234b138351d0d51786254" STYLE="fork"/>
                  <node TEXT="遍历lane segments，计算限速值" ID="a87d47962eaebfbd46fa0f07882d9785" STYLE="fork">
                    <node TEXT="根据ICS上巡航车速偏移方式（绝对值/百分比）计算限速值" ID="452dcaf455e0de4bf96d1bf886873766" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="当前local route的left/right neighbor route计算分段限速值" ID="b72752ec85f832b24d3cd90cbadca19c" STYLE="fork"/>
              </node>
              <node TEXT="当前为EGO_HDMAP，则本地路由impl为HDMapLocalRouter" ID="66e9ed6c7c9d3c5b1000fc0e0a447e4e" STYLE="fork">
                <node TEXT="检测距离1700m，规划距离800m，更新距离100m" ID="ee5e3b830ace733bbf5ba23168285b70" STYLE="fork"/>
                <node TEXT="更新road map（更新时间）、navi map（tile id）、全局路由信息（更新时间）" ID="674ee6c6d612875bbb0260c76f8cb205" STYLE="fork"/>
                <node TEXT="根据规划的init point和目标route id搜索hdmap中的最近的lane及其way point" ID="34c6944d09fe675e5c217265a0fdcb38" STYLE="fork">
                  <node TEXT="根据lane id查road map获取当前lane" ID="77a8a8fdb809a1df65da146d06c55d04" STYLE="fork"/>
                  <node TEXT="深度优先找到lane的潜在的候选集" ID="5252c29fdffaf500459ef55c34d87de9" STYLE="fork">
                    <node TEXT="计算当前lane的中心线的最后一个点和init point的距离" ID="346015a8341f92b5640919f898b5c787" STYLE="fork"/>
                    <node TEXT="若距离小于20m，则将当前lane的后继加入候选集" ID="49a24799d29d96f0741caab0a24103ce" STYLE="fork"/>
                    <node TEXT="若左前/右前的lane有效，则将其加入候选集" ID="96c8f188a49959236755e7a4c80f6cbb" STYLE="fork"/>
                    <node TEXT="并将当前lane的所有前驱的后继加入候选集" ID="ca066531458ff2593edbb12983c14272" STYLE="fork"/>
                    <node TEXT="对候选集的lane继续深度优先遍历" ID="aa758fbf4e96020dd34d3c4e3ec92d9d" STYLE="fork"/>
                  </node>
                  <node TEXT="获取有效lanes" ID="09a64fbbe685cb6b365a707b0cd4fcdc" STYLE="fork">
                    <node TEXT="使用KNN搜索离规划的init point最近的lanes" ID="8367f23306404e57ed36909c4aff444b" STYLE="fork"/>
                    <node TEXT="KNN搜索失败，使用Radius为15m搜索离规划的init point最近的lanes" ID="c122e562d8ac0e70a125ed56b1c27fb9" STYLE="fork"/>
                    <node TEXT="取最近的lanes和潜在的候选集的合集" ID="01dd90471028825aac9511c1d70acf9a" STYLE="fork"/>
                    <node TEXT="过滤出在目标route上的lanes" ID="0a502c7d9b49a6b11246312608e75ceb" STYLE="fork"/>
                  </node>
                  <node TEXT="找到lanes上最近的way point信息" ID="6ca1d1c6bbb2752218d1df39960de68d" STYLE="fork"/>
                  <node TEXT="获取way point的全局路由信息（hd link, hd link segment index）" ID="ebbf3741479a3eda0e2d2a1c199b5ec7" STYLE="fork"/>
                </node>
                <node TEXT="获取way point在route上的s" ID="6a134c61b0741ada684755a8a6f862bc" STYLE="fork"/>
                <node TEXT="是否触发本地路由更新" ID="13a101809f252b991d21e7ae51d8566b" STYLE="fork">
                  <node TEXT="若自车在shoulder lane或不在全局路由上，则不更新" ID="fb431c9a798b1bfc7cb088acb52bbf40" STYLE="fork"/>
                  <node TEXT="更新条件" ID="26d73a0c2a55a10bce41b669bc736236" STYLE="fork">
                    <node TEXT="找不到路由" ID="585455152c2df9d69ef7201880070f48" STYLE="fork"/>
                    <node TEXT="local router update request" ID="21d5855b0dec24e068c5e34b830b15d7" STYLE="fork"/>
                    <node TEXT="MD &amp; auto mode" ID="868b526d14b830b1aa668689cbb0fff2" STYLE="fork"/>
                    <node TEXT="当前的路由的剩余长度&lt;30m且当前路由同时没有left，right neighbor router且当前路由的lane不在全局路由上" ID="82936b5faae6c388dde8cfbb8f6c620e" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="更新本地路由" ID="68d9af9b21963e879ebcd4f982f44946" STYLE="fork">
                  <node TEXT="根据way point生成本地路由" ID="3d25cca899992f1e48498816f881caa3" STYLE="fork"/>
                  <node TEXT="构建routes关系" ID="71977b582bc0221998565e739bd3cf26" STYLE="fork">
                    <node TEXT="遍历所有的routes" ID="ed628f1c0325d20c103bee1c44276c2b" STYLE="fork">
                      <node TEXT="找到left branch的routes" ID="255236db857e92d3e1f5a7465127a5d5" STYLE="fork">
                        <node TEXT="当前route的左为left route" ID="0b54dffd3aaab7619fef3e4bdedf7e38" STYLE="fork"/>
                        <node TEXT="left route的右为当前route" ID="f456da376e3729acaaec9edb8446cc45" STYLE="fork"/>
                      </node>
                      <node TEXT="同理对于right branch的routes" ID="b388e64f9a7a3ce3595177ca5c1ad364" STYLE="fork"/>
                      <node TEXT="更新相邻车道的路由关系" ID="4a4d76f2e475e062504f1866a1d3ce85" STYLE="fork">
                        <node TEXT="遍历lane segments" ID="9a3a557171104d70989cae6dd3c96d09" STYLE="fork">
                          <node TEXT="左车道存在" ID="62af547b658058ae59f1509d58a6f2ad" STYLE="fork">
                            <node TEXT="遍历左车道的local routes" ID="54e118dcac4e319d78d722cf7a568116" STYLE="fork">
                              <node TEXT="check左车道是否在左车道的local routes上有效" ID="7c0c615c1c013adafedf43601a85cb5a" STYLE="fork"/>
                              <node TEXT="取当前lane的左车道线" ID="402822064cd3676e02ec171b93aa36fc" STYLE="fork">
                                <node TEXT="若为双向或右到左可跨越，则更新左车道的local routes的可跨越关系，否则更新不可跨越关系" ID="2d9d8b868f0a4ccca8f78ba2bc8a7e44" STYLE="fork"/>
                              </node>
                            </node>
                          </node>
                          <node TEXT="右车道存在" ID="a9ec55dc43457c11559fcc8a546fdcb4" STYLE="fork">
                            <node TEXT="遍历右车道的local routes" ID="c1eda30d851583e73fa3a0909e62de59" STYLE="fork">
                              <node TEXT="check右车道是否在右车道的local routes上有效" ID="7bf75d567895f4bdfbebddfa89510a6b" STYLE="fork"/>
                              <node TEXT="取当前lane的右车道线" ID="2cb756a0b5a07927f7294e1fb8172a2b" STYLE="fork">
                                <node TEXT="若为双向或左到右可跨越，则更新右车道的local routes的可跨越关系，否则更新不可跨越关系" ID="1f671a65cd50221ecd8853ae16147399" STYLE="fork"/>
                              </node>
                            </node>
                          </node>
                        </node>
                      </node>
                    </node>
                  </node>
                  <node TEXT="更新当前routes" ID="e3cd7f0497a605da4c2f08478ef6cb36" STYLE="fork">
                    <node TEXT="遍历所有的routes" ID="eb0584b6284d856532a04d6dd3e4682c" STYLE="fork">
                      <node TEXT="更新route的属性" ID="e94a0b42fda0032057770b484e442335" STYLE="fork">
                        <node TEXT="DFS遍历routes的lane segment" ID="4ec3a9bf0867a74a1c88b39da81c3691" STYLE="fork">
                          <node TEXT="merge点/split点，检测长度，是否退出等" ID="2ef28a78e7d1ebad41548bc8c4ef664f" STYLE="fork"/>
                        </node>
                      </node>
                      <node TEXT="若route可以退出，则设置高优先级" ID="07e1a4462d256535b4ccdc9ee22cef73" STYLE="fork">
                        <node TEXT="left neighbor router可以退出，则设置高优先级" ID="e9515c6af429ae944d8ec2569408e617" STYLE="fork"/>
                        <node TEXT="right neighbor router可以退出，则设置高优先级" ID="2e5c4e1b4cd172e254a5faa136e3dae9" STYLE="fork"/>
                      </node>
                      <node TEXT="计算route和上次路由的overlap（相同lane的长度重叠率）" ID="5fd82db5995cd8c63f0398f4d44aa049" STYLE="fork"/>
                      <node TEXT="计算下匝道距离（init point投影到route）" ID="cbe2f2244efe40d915458ad635464cbb" STYLE="fork">
                        <node TEXT="遍历lane segments，若lane type为left/right dece lane" ID="14338a64bb3f0fbf98c5b44956e7db27" STYLE="fork"/>
                      </node>
                      <node TEXT="计算上匝道距离" ID="b0c66a524bfaca3aba4a28bbdaf23642" STYLE="fork">
                        <node TEXT="遍历lane segments，若lane type为left/right acce lane" ID="53f3abb92bea2686b4ba2a5262051e0f" STYLE="fork"/>
                      </node>
                    </node>
                    <node TEXT="对routes排序：高优先级，overlap长，下匝道距离小，宽度小，长度长" ID="f9a70557466aee06d84fd8f583f94d41" STYLE="fork"/>
                    <node TEXT="当前local route为最高优的route" ID="498bf3608b72d5a3dce7a91468103aaa" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="更新限速信息" ID="7f47e6d0b9488dd28af5f46f8cded8f3" STYLE="fork">
                  <node TEXT="更新当前和下段的限速（限速变化）（法规、经验、电子眼）、到限速变化的距离、及road type（默认取lane type，下匝道例外）" ID="f8958f8fc311c3164c60ce7c536f3aaa" STYLE="fork">
                    <node TEXT="法规限速默认取lane group的最大限速，对于left/right dece lane，取车道限速" ID="6e3ff10926a8b1b59bd6830047e6a1cb" STYLE="fork"/>
                  </node>
                  <node TEXT="根据用户set speed计算分段限速" ID="9383978a04a791b85d1cf04e88a811d5" STYLE="fork">
                    <node TEXT="当前local route计算限速值" ID="ce756b4e41131494106dcd5309e46d60" STYLE="fork">
                      <node TEXT="将用户set speed作为初段的限速值" ID="135843341d2549d5184826a234d4f143" STYLE="fork"/>
                      <node TEXT="遍历lane segments，计算限速值" ID="7bafff7c3a6ff29c3f05f36ed70e3c5b" STYLE="fork">
                        <node TEXT="根据ICS上巡航车速偏移方式（绝对值/百分比）计算限速值" ID="2a7617daeee8d7e9257dbae8321952d0" STYLE="fork"/>
                      </node>
                    </node>
                    <node TEXT="当前local route的left/right neighbor route计算分段限速值" ID="31bc2a2909a245e78ddb4d79a49f8a76" STYLE="fork"/>
                  </node>
                </node>
              </node>
              <node TEXT="其他，则本地路由impl为LaneMapLocalRouter" ID="b7e613d4e2298a2babf3a2ad02f7fb46" STYLE="fork">
                <node TEXT="检测距离1000m，规划距离300m，更新距离100m" ID="52dd54946e0695afacd2d17b272f8494" STYLE="fork"/>
                <node TEXT="根据规划的init point搜索local route上的way point" ID="5029da7b37d1cd027977b46dcaa50265" STYLE="fork">
                  <node TEXT="init point搜索local road map中的最近的lanes（最多16条，MD最多4条）" ID="71af75d028fb14809a61991699b06d65" STYLE="fork"/>
                  <node TEXT="当前local route有效，且为AD" ID="17a12f90e511c3792cd21ad6e27a5470" STYLE="fork">
                    <node TEXT="遍历最近的lanes，找到最优匹配的way point信息" ID="3dd847a98909acffe11d337842af592c" STYLE="fork">
                      <node TEXT="将init point投影到lane，计算s, l" ID="fe725c30ccac7ff6fb4d94ab12f4617b" STYLE="fork"/>
                      <node TEXT="若投影点超过lanes的有效长度或自车的heading和lane的heading差超过0.6pi，则忽略" ID="2ab47ed0bff0a6057d1efbdab23a37ec" STYLE="fork"/>
                      <node TEXT="遍历lane上的中心线上的点，将点投影到local route，得到s, l" ID="36c38e4792aa45e551bbf3329a2d176b" STYLE="fork"/>
                      <node TEXT="计算average横向l" ID="74c63a7381e627611a520aba1f624321" STYLE="fork"/>
                      <node TEXT="最小的average横向l作为way point" ID="578d89176476cb81847ef3b2522e2bf7" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="否则" ID="3ec83d432162ba33446400e17f28ddbc" STYLE="fork">
                    <node TEXT="找到最近的lanes上最近的way point信息" ID="990476c294dbcb86ebcdeaa8d05670ff" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="将way point投影到当前local route上，得到s, l" ID="9748e96e90826b05f1ae044b815a5928" STYLE="fork"/>
                <node TEXT="根据way point生成本地路由" ID="9f0c7b5f6cddf0afaf5044e83e0cbd30" STYLE="fork"/>
                <node TEXT="计算限速信息" ID="ac5e7164e3e1afc4793a93b1f6b12e66" STYLE="fork">
                  <node TEXT="当前local route计算限速值" ID="6b8913a0c7e01901e2e6de3fab6327ec" STYLE="fork">
                    <node TEXT="将用户set speed作为初段的限速值" ID="dbfc52d3ff43179f3fbb878f229a3659" STYLE="fork"/>
                    <node TEXT="遍历dynamic map的sd segments，sd的限速值作为分段限速" ID="1b1ed58880ccf16647df270bc61d9ade" STYLE="fork">
                      <node TEXT="根据ICS上巡航车速偏移方式（绝对值/百分比）计算限速值" ID="a7036032d4b3f5b2d6936d447962bb44" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="当前local route的left/right neighbor route计算分段限速值" ID="6a955471f5deeac2ed7e43e5ae0c85f9" STYLE="fork"/>
                </node>
                <node TEXT="更新限速信息" ID="bd5207df4e2e77a38a50b248ae52e5d8" STYLE="fork">
                  <node TEXT="使用dynamic map的sd segments的限速更新当前和下段的限速（限速变化）" ID="d02e638cdc3f967929b88bd93fd2eeed" STYLE="fork">
                    <node TEXT="经验、电子眼=法规" ID="a4439ce9b5c5ddbcaffe1c273dfc234f" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="check Lane Map的质量" ID="76c1a1275a594dea2a23aad121e7e765" STYLE="fork">
                  <node TEXT="获取init point在local route上的最近点s, l，s小于5m，或者剩余route长度小于30m，则为无效" ID="1df660d990a2a1b0a252c06b1ba396f3" STYLE="fork"/>
                  <node TEXT="和上次的l偏差超过3m，则为无效" ID="4b0dae875ef639972642fe6c42e56201" STYLE="fork"/>
                </node>
                <node TEXT="无效则更新失败" ID="edd9abb4aab505dedc8c428fcb5242fb" STYLE="fork"/>
              </node>
            </node>
          </node>
        </node>
        <node TEXT="参考线生成更新" ID="af7a2ef017a90fe8ba20bd7c7c56fb64" STYLE="fork">
          <node TEXT="按照LaneReferenceLineGenerator更新" ID="fbb0c82d6f213a6cff4cf16cbfefa9e2" STYLE="fork">
            <node TEXT="根据way point更新current local route上的route position" ID="b286f01f9b456651555f98d1ee9dcacd" STYLE="fork">
              <node TEXT="找搜索范围内的最近点" ID="1368dc0bb0b26494756a51ea212fc979" STYLE="fork">
                <node TEXT="start：max（0， way_point.s_route-10m）" ID="55093dcf9ba0da1c2744676870ebd7ef" STYLE="fork"/>
                <node TEXT="end：max（10m, speed*1s+0.5*2m/s2*1s*1s)" ID="e6846978c89626b448f42e529f8916ea" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="根据way point更新left/right local route上的route position" ID="111cb1e22c88ba1eb5615ca6e7dc0183" STYLE="fork">
              <node TEXT="根据当前车道找left/right lane id，进而找left/right lane id所在的left/right neighbor route作为候选route" ID="2ab4c0da69cbe2c7c8b82cd4261dca71" STYLE="fork">
                <node TEXT="过滤lane segments为空的route" ID="06e0a03660e2dfe50a4944d6714b058d" STYLE="fork"/>
                <node TEXT="相同优先级的route对比" ID="e4d6d704f1fdb13fe4590b7478cade6c" STYLE="fork">
                  <node TEXT="通过route间的overlap，找split lane，并得到split lane的后继，计算中心线的最后两个点的heading，heading_diff最小作为最优route" ID="595aa902a498d7a85031eb849e6af2e9" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="根据init point计算left/right最优route position" ID="fed0c3c3a01d0ffb854c7a7dce28c631" STYLE="fork"/>
            </node>
            <node TEXT="对于current/left/right local route增加boundary信息" ID="0b821ed982508c2742a5ceba922f5b15" STYLE="fork"/>
            <node TEXT="遍历left/middle/right三条参考线" ID="ff386e6dda2c628a95100508cf7053af" STYLE="fork">
              <node TEXT="更新线上每个参考点的限速信息" ID="27c9fbd001c93497978e518d83f44e90" STYLE="fork"/>
            </node>
            <node TEXT="根据left/middle/right三条route及其position更新参考线信息" ID="1e8bef981ceb11ad5725d02cc6e71545" STYLE="fork">
              <node TEXT="创建DiscretePointsReferenceLine或QPSplineReferenceLine" ID="8de3cfcff0e16359445623a514f957c7" STYLE="fork">
                <node TEXT="算法详解" ID="b9c14bc4465fd0158125d69a27bbe500" STYLE="fork">
                  <node TEXT="https://liuxiaofei.com.cn/blog/apollo%E5%8F%82%E8%80%83%E7%BA%BF%E4%BC%98%E5%8C%96%E4%B9%8Bdiscretepointsreferencelinesmoother/" ID="d4174e1b8240d87ca106ba59043ffc6a" STYLE="fork"/>
                  <node TEXT="https://www.jianshu.com/p/75866a603065?utm_campaign=maleskine" ID="5b0655d0d6413121f7ad3bf140af0948" STYLE="fork"/>
                </node>
                <node TEXT="DiscretePointsReferenceLine的更新" ID="34bdc4ba9d30ce4bc92b214c2fa72cef" STYLE="fork">
                  <node TEXT="更新参考线策略" ID="d51b1ec71db59259acdd27b0d29930f7" STYLE="fork">
                    <node TEXT="距离上次route的s更新超过60m" ID="62597a3a2072f784b98f74f97844757a" STYLE="fork"/>
                    <node TEXT="route Id变化" ID="bff3245dc1e5debc7fcbc1af625e9079" STYLE="fork"/>
                  </node>
                  <node TEXT="生成anchor point" ID="a60e29dd47669d1a6b45f17131034f13" STYLE="fork">
                    <node TEXT="按照1m采样anchor point" ID="386f30957f10edd96d91152816b3de84" STYLE="fork">
                      <node TEXT="anchor point" ID="c447d8e4da08b491018243181583a470" STYLE="fork">
                        <node TEXT="左边界 = clamp(左车道线-0.5*车宽, 0.1m, 3m)" ID="390c4edb34a555f84145d1579a9e1e97" STYLE="fork"/>
                        <node TEXT="右边界 = clamp(右车道线-0.5*车宽, 0.1m, 3m)" ID="f88dabeead5e72353c6732fef89af3c9" STYLE="fork"/>
                        <node TEXT="横向边界 = clamp(0.5*(左边界+右边界), 0.1m, 3m)" ID="ef8eafca7991cfd57528ec32d709f626" STYLE="fork"/>
                        <node TEXT="boundary为physically not" ID="616011129164e489b6ac60d8cdd284c5" STYLE="fork">
                          <node TEXT="边界buffer = max(0.3m, 1.0m)，0.3为lateral_buffer，1.0为distance_to_curb，并按照到左车道的左车道线和左车道线的距离修正" ID="031c52a8c54acb567c6a54ae568425e8" STYLE="fork"/>
                        </node>
                        <node TEXT="左/右边界减去边界buffer，保底0.1m" ID="91babd36a47bb51c4c8db858c2992116" STYLE="fork"/>
                        <node TEXT="在左/右转时，限制左/右边界为min(0.2m，左/右边界)" ID="c6edb740d3d89286a37ad328e25765e5" STYLE="fork"/>
                        <node TEXT="若非左/右转车道，且左/右boundary长度不够异常延伸，则限制右/左侧的横向偏移" ID="8edf4811abc43779e62c84e654f8b37c" STYLE="fork"/>
                        <node TEXT="纵向边界，若为lane map，则为0.05m，否则为3m" ID="670e75343a166acb136717831d189f2e" STYLE="fork"/>
                      </node>
                    </node>
                    <node TEXT="计算anchor points的heading，曲率kappa和曲率变化率dkappa" ID="d941a0e31d5d7a95a81730c466a5ed5c" STYLE="fork"/>
                    <node TEXT="根据kappa的正负，调整anchor point的左/右边界" ID="5f2373086e1a80c6bfc87510c6ef0556" STYLE="fork">
                      <node TEXT="曲率为正，左边界（0.1m），右边界（车道宽度-0.5车宽）" ID="0721f82b396ebbe4a9c935943c0ae6b2" STYLE="fork"/>
                      <node TEXT="曲率为负，左边界（车道宽度-0.5车宽），右边界（0.1m） " ID="826fb8edcbe89a0c443f5fcb05ec3fc4" STYLE="fork"/>
                    </node>
                    <node TEXT="anchor point的首尾的横向/纵向边界为0" ID="859834f3ad858f20cdb92806fab6a953" STYLE="fork"/>
                  </node>
                  <node TEXT="使用FemPosDeviationSmoother进行平滑" ID="6616a5f819ea7c7a8dc343bf8df8b385" STYLE="fork"/>
                  <node TEXT="平滑后，重新计算ref point的heading，曲率kappa和曲率变化率dkappa，并针对限速、左右车道线宽度做插值处理" ID="a2211c42a8d7abfa7ff39ec7729d4103" STYLE="fork"/>
                  <node TEXT="更新navi path" ID="207342cbd70eff47ae1f1e1f2f3da02a" STYLE="fork"/>
                </node>
              </node>
            </node>
          </node>
          <node TEXT="NOT_FS下的更新" ID="e80eb84e4bf445137ebcc11c3bdfdfc0" STYLE="fork">
            <node TEXT="遍历所有的scene fs strategies，都不满足进入条件（第一个满足的作为current fs strategy）" ID="d83d71dc69efd69102d9819b9a83efea" STYLE="fork">
              <node TEXT="按照LaneReferenceLineGenerator更新" ID="5f458e92c21fd33b80fe6012d0cc5d53" STYLE="fork"/>
            </node>
            <node TEXT="否则" ID="0c0b4aeac7d289da95cf7939477c853e" STYLE="fork">
              <node TEXT="车速大于（2m/s）" ID="79a8d3afac8fc0a117d895cb6d36bee4" STYLE="fork">
                <node TEXT="降低车速，继续按照LaneReferenceLineGenerator更新" ID="9a8cb1ed1606a2c2266b2553fc2834c5" STYLE="fork"/>
              </node>
              <node TEXT="否则" ID="99f573829c8a976c18da7d224740f0f9" STYLE="fork">
                <node TEXT="清除LaneReferenceLineGenerator生成的参考线" ID="6828821e5dd0ec2392bcb6e75f02b118" STYLE="fork"/>
                <node TEXT="重置FS状态（状态、转向灯、分段path等）" ID="653c947aee50f3ddf8812579b746652e" STYLE="fork"/>
                <node TEXT="触发FS plan" ID="85dc13daa48d09b49c796a09a0146c63" STYLE="fork">
                  <node TEXT="按照current fs strategy准备Fs Input" ID="70735f24747a758db1382528b9916c3d" STYLE="fork">
                    <node TEXT="起点（当前位姿）" ID="996a8c47b89beed1ac9429c3f58b3437" STYLE="fork"/>
                    <node TEXT="终点" ID="89d2d526664d0eee4bae7b6280b3d959" STYLE="fork">
                      <node TEXT="每个Fs Strategy" ID="0010315c19bfd898d7c0a147421ce127" STYLE="fork"/>
                    </node>
                    <node TEXT="生成XY边界（前后30m，左右30m）" ID="07928102eaa5ce9ecc016cf2ab40f3b6" STYLE="fork"/>
                    <node TEXT="根据OD生成OBS的polygon" ID="d1a34d1dfb50881085e5b86bf421171d" STYLE="fork">
                      <node TEXT="遍历Perception Obs" ID="595268ac94613efac0d136eb2b871866" STYLE="fork">
                        <node TEXT="过滤unknown, static unknown, dynamic unknown类型的object" ID="3164845d41b665e39e9068a053269855" STYLE="fork"/>
                        <node TEXT="过滤速度大于static obs speed threshold的object（0.5m/s）" ID="211cd771d12e7740b8a9b926e9108e03" STYLE="fork"/>
                        <node TEXT="计算object的2d的polygon角点" ID="6a32215f3ba174f3ed38a4773efc054e" STYLE="fork"/>
                      </node>
                    </node>
                    <node TEXT="根据road map的lane boundary生成polylines" ID="0a19f10ee6fd29251b74361d95385c86" STYLE="fork">
                      <node TEXT="根据起点（当前位姿），找最近lanes（前后10m，左右10m，步长0.3m）" ID="a05d2091a173903407f90feae7abd186" STYLE="fork"/>
                      <node TEXT="对lanes去重，并根据XY边界过滤" ID="b0748780ebb3025ef9069ba01a56fc24" STYLE="fork"/>
                      <node TEXT="遍历lanes" ID="33bafcbba521ddba012b01ac61cea3b3" STYLE="fork">
                        <node TEXT="获取左/右的lane boundary，且boundary为physically not" ID="8d9cc97f4d21ea3c447a8c5241142105" STYLE="fork">
                          <node TEXT="按照1m的间隔采样，生成boundary点的polyline" ID="f8763a4d92ad104d52a0695ea044f510" STYLE="fork"/>
                        </node>
                        <node TEXT="根据左右lane boundary的end point，生成polyline" ID="1b292a3098214a499a149889788344ed" STYLE="fork"/>
                      </node>
                    </node>
                    <node TEXT="为换电柜生成polylines" ID="d83eb6a9da3de533ae2b7b5c934430b5" STYLE="fork"/>
                    <node TEXT="根据grid map计算点目标信息" ID="301dae9b7540f7d84e72a1f1ab53202e" STYLE="fork">
                      <node TEXT="根据grid map的时间戳插值得到grid map to car pos的transformation" ID="db173f0b6fa317e60c303928ba486691" STYLE="fork"/>
                      <node TEXT="grid map to map的transformation = map to car pos.inverse() * grid map to car pos" ID="8916f8251b6ee98b969b793398444367" STYLE="fork"/>
                      <node TEXT="cell to map = grid map to map * grid to cell.inverse()" ID="b6764478c62bfae85594c4b7da4a5553" STYLE="fork"/>
                      <node TEXT="遍历grid map的cell" ID="87ac598b236439f5b5f4515a3e228e5a" STYLE="fork">
                        <node TEXT="过滤语义的地面点cell" ID="71714e124d0f2059a7dda04815a5ae58" STYLE="fork"/>
                        <node TEXT="计算cell的中心点" ID="b70d1e78a3cb784690f7a3123e4184f6" STYLE="fork"/>
                        <node TEXT="得到point in map = cell to map * point" ID="6867ce161ad8b362e3775103ae887f9b" STYLE="fork"/>
                      </node>
                    </node>
                    <node TEXT="基于goal更新转向灯信息" ID="2140dd666ac6bee3a3915afb1f8a105b" STYLE="fork">
                      <node TEXT="若为accurate goal，则goal的锚点为终点" ID="a5d459f9993f8e471fce52ba918b7519" STYLE="fork"/>
                      <node TEXT="否则，goal的锚点为第一个fuzzy goal点" ID="acc19f7b19c1784645c6de3854d817a9" STYLE="fork"/>
                      <node TEXT="heading_diff = goal的锚点的heading - 自车的heading" ID="79aa2a1e6cdd10c7a01a464f47f8ef18" STYLE="fork">
                        <node TEXT="若23 &lt; heading_diff &lt; 100，则为左转向" ID="a84f869e3b224fcd546b80c92d429490" STYLE="fork"/>
                        <node TEXT="若-100 &lt; heading_diff &lt; -23，则为右转向 " ID="f140fa06aba2ec2c4b2fbe3d6e91dc39" STYLE="fork"/>
                      </node>
                      <node TEXT="计算goal的锚点和自车位置间的pos_angle" ID="78f9a6e061ee1efaf29f42892c5e2c44" STYLE="fork"/>
                      <node TEXT="angle_diff = pos_angle - 自车的heading" ID="f1c0adabb2c398a8e8887e6b7106451b" STYLE="fork">
                        <node TEXT="若23 &lt; angle_diff &lt; 100，则为左转向" ID="0233f93c343468a20f3f22b0c77c1717" STYLE="fork"/>
                        <node TEXT="若-100 &lt; angle_diff &lt; -23，则为右转向 " ID="b412b20179c39eeb882130d7c403bc66" STYLE="fork"/>
                      </node>
                    </node>
                  </node>
                </node>
                <node TEXT="更新FS状态为WAIT_FS_PATH" ID="011604d6918b0964c2fbf22cadd26393" STYLE="fork"/>
                <node TEXT="若FS为stop_wait_for_fs_path" ID="39ef1397002963dc6623973db404e82a" STYLE="fork">
                  <node TEXT="生成StopRef（提供给换电站定位框）" ID="71fcc14abfaa0f5d98b60b3758ed4187" STYLE="fork">
                    <node TEXT="从自车位置开始，用当前heading和曲率，按照0.1m的分辨率分段生成圆弧曲线，总长度1.5m" ID="cc54035db2dc8660c92b6291f42daf5b" STYLE="fork"/>
                    <node TEXT="更新Fs参考线" ID="3540d012eb77ff5895854daf6c93dc9d" STYLE="fork">
                      <node TEXT="FsRaw参考线" ID="d9545ecd411c25bc73591b3b529c70e9" STYLE="fork">
                        <node TEXT="左右边界=0.5车宽+0.3m，边界类型为physically not，限速为1.0m/s" ID="31ece40f1694ce4b69c8c9e4c979da94" STYLE="fork"/>
                      </node>
                    </node>
                  </node>
                </node>
                <node TEXT="否则，按照LaneReferenceLineGenerator更新" ID="f96c9d6688c194fb63a16f33468e039e" STYLE="fork"/>
              </node>
            </node>
          </node>
          <node TEXT="WAIT_FS_PATH下的更新，含GEAR_SHIFT和ON_TRACK" ID="ddd03abdce1ba834a016beddb032e870" STYLE="fork">
            <node TEXT="混合A*规划" ID="7314344c73696b0ec9967f456e51b22a" STYLE="fork">
              <node TEXT="" ID="90b14a4c41e5754d8df1386a29d1d0d7" STYLE="fork"/>
              <node TEXT="将OBS的polygon和lane boundary生成polylines统一转成line segments" ID="9c2ce95cf5d13b8def63dfa70fd9202f" STYLE="fork"/>
              <node TEXT="按0.05m分辨率生成Grid Distance Map图" ID="4bfc050919aea211ac44b90aafbcbdf9" STYLE="fork"/>
              <node TEXT="按照DP（dijistra）进行搜索，得到多条轨迹" ID="e3e92ff9ae76b24bed307a47f4d5e84a" STYLE="fork"/>
              <node TEXT="计算轨迹的cost" ID="0c79ca75681188ee79eecfbd9e9ad3ad" STYLE="fork">
                <node TEXT="计算换挡、转向惩罚的cost" ID="9d7588dc53a045f1e7db2a5bcb0446f0" STYLE="fork"/>
                <node TEXT="使用Grid Distance Map图计算到OBS的距离cost" ID="c3e6720bc0dd10abd3810b339b894035" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="使用IterativeAnchoringPathSmoother进行轨迹分段平滑" ID="6e241c020096cddf107df7a14f9ec03b" STYLE="fork"/>
            <node TEXT="将分段的path拼接起来" ID="35503c5085b868eeacf9e4707d29bc76" STYLE="fork"/>
            <node TEXT="若实际档位和目标档位一致" ID="ba925f530fafeae7ee6dab6b9e9fcc06" STYLE="fork">
              <node TEXT="更新FS状态为ON_TRACK" ID="2b3c0d8cf9ce33efaae4284df65da04d" STYLE="fork"/>
              <node TEXT="onTrackUpdate" ID="50c0efd281dac11030ea5896d58a8926" STYLE="fork">
                <node TEXT="本段path已经结束，则更新FS状态为GEAR_SHIFT，并生成StopRef" ID="051308342989700b565a490103e8a24f" STYLE="fork"/>
                <node TEXT="接近终点，更新FS状态为FINISH，生成StopRef" ID="9382a4dcc9ad8fbadc30f4df34cc9c64" STYLE="fork"/>
                <node TEXT="是否需要重规划" ID="ecb6e13f2ea72e9a2374cecab1ef1238" STYLE="fork">
                  <node TEXT="计算自车当前位置的最近path point" ID="cd3ec0068e9cfef7a1032fce4f4d4e9c" STYLE="fork">
                    <node TEXT="lat_diff = (ego_xy - 最近点的xy).cross(cos(最近点heading), sin(最近点heading))" ID="c57e1fb158c540d726add004eace97c5" STYLE="fork"/>
                    <node TEXT="start_lon_project = (ego_xy - path起始点的xy).cross(cos(path起始点的heading), sin(path起始点的heading))" ID="fdf54b5090fdae532db6f24a0283e593" STYLE="fork"/>
                    <node TEXT="end_lon_project = (ego_xy - path终点的xy).cross(cos(path终点的heading), sin(path终点的heading))" ID="642ff7e90fd93f8d5764bb75e6d712da" STYLE="fork"/>
                  </node>
                  <node TEXT="abs(lat_diff)超过1m，重规划" ID="453fa42cca3e7e44f068e1f855320ed2" STYLE="fork"/>
                  <node TEXT="start_lon_project &lt; -2m，重规划" ID="6735f44e702270b18d39749aa59d7a59" STYLE="fork"/>
                  <node TEXT="end_lon_project &gt; 2m，重规划" ID="2068dcfe4a8a77e01747925c9386bd37" STYLE="fork"/>
                </node>
                <node TEXT="重规划和FS plan一致，更新FS状态为WAIT_FS_PATH" ID="58ae1a4e65b1a1fe715cbf4a22eb9fdc" STYLE="fork"/>
                <node TEXT="更新Fs参考线信息" ID="82c70917e45f51cf4fccb69fc3152473" STYLE="fork">
                  <node TEXT="根据自车当前位置更新route position" ID="30b2fd67fc93c09455876db31e016e7a" STYLE="fork"/>
                  <node TEXT="若到目的地，则生成reason为DESTINATION的停止墙" ID="bc950841d028f9b6e6cc0fe41333661e" STYLE="fork"/>
                </node>
              </node>
            </node>
            <node TEXT="若实际档位和目标档位不一致，根据当前位置和当前分段path上的第一个点的heading和曲率生成stitch path" ID="3ab4c388af2fe13a3ec303e26544c21f" STYLE="fork"/>
          </node>
          <node TEXT="FINISH下的更新" ID="184ab25643355dcac9bf968ef7e1aee7" STYLE="fork">
            <node TEXT="生成StopRef" ID="f2aa36c3711163ff3d7f089420df42cf" STYLE="fork"/>
            <node TEXT="根据当前位置和heading生成stitch path，回正" ID="9b7f4177a6a6ef4f1df1665b381c998c" STYLE="fork"/>
            <node TEXT="设置P档" ID="36ac0279cae4e41cc4ba38aecccf3691" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="执行交通规则（红绿灯、转向灯）" ID="22196a4fd11dbdcadf09f784bda4546e" STYLE="fork">
          <node TEXT="红绿灯" ID="9aedcf516f76917c3fa92c2e728dcc41" STYLE="fork">
            <node TEXT="dynamic map中的路口红绿灯信息" ID="001306cda8ac4f0baf8c7def59808d2a" STYLE="fork"/>
            <node TEXT="遍历navi path" ID="c53d3160b34b81f22efbfa8a118d22ca" STYLE="fork">
              <node TEXT="该lane有停止线的overlap" ID="d9b5ddd0dbda99b4f73ede75d74dbe11" STYLE="fork">
                <node TEXT="在dynamic map中的路口红绿灯信息中找停止线和路口红绿灯的映射关系" ID="702de62b1c4e0c1807b02158bc0bdac0" STYLE="fork"/>
                <node TEXT="找到target lane、target stop line和target traffic light，并根据target lane得到target turn方向" ID="83eaa78248e6d14006e4a81063230407" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="路口红绿灯信息有效，则根据target turn方向选择target traffic light状态" ID="1a4d4b85d756dabb81ef21afe91897f9" STYLE="fork"/>
            <node TEXT="计算停止线的位置s" ID="fe3c93bac772824b9dba01ec16b90b19" STYLE="fork">
              <node TEXT="遍历停止线的点，并根据其在current local route上的最近点，得到最小s" ID="000431015bfc0114a4e32b43c881d10d" STYLE="fork"/>
              <node TEXT="若停止线在自车身后或者s大于300m或来源不是hdmap，忽略" ID="a27c19c52b3b0cf5e9e1000f60155803" STYLE="fork"/>
            </node>
            <node TEXT="遍历dynamic map中的路口红绿灯信息（多个灯）" ID="20197d59dfe3ce9d366c9bdd3f3f128c" STYLE="fork">
              <node TEXT="若为target traffic light" ID="57e17de4751f686d53640dfd2d16c6e3" STYLE="fork">
                <node TEXT="根据红绿灯的状态，生成红绿灯的停止决策" ID="831ec32add548b367f978400fd31f9e3" STYLE="fork">
                  <node TEXT="红灯/灭灯，stop decision的原因为红绿灯，停止点的位置为停止线s，同时初始化黄灯tracking时间" ID="4fd54c19f678546b8102cf94f0dc32c3" STYLE="fork"/>
                  <node TEXT="黄灯，当前时间相对黄灯开始tracking时间是否大于2s，若是，和红灯的停止决策相同" ID="9e4501aaaa4ee6e1e1c61574fab12b9d" STYLE="fork"/>
                  <node TEXT="绿灯/unknown，无停止策略" ID="152ff0674ab46416175863e553cba85e" STYLE="fork"/>
                </node>
              </node>
            </node>
          </node>
          <node TEXT="转向灯（仅对于PSP）" ID="7da775aee9abbfd47003e61fa3f86b87" STYLE="fork">
            <node TEXT="详见​服务区打灯策略​" ID="c8fd7ca963afebfc11c33ed6ab4827f0" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="更新obs信息" ID="d112efc9f3bda9b01127fbb2144c2d32" STYLE="fork">
          <node TEXT="若需要更新local map或Freespace场景，则根据自车位置和road map更新local map" ID="a10a75bd917537d22e026dce69a362cd" STYLE="fork">
            <node TEXT="创建kdtree（2维，16个点）" ID="7c81631ad8233c340941af64581b48df" STYLE="fork"/>
            <node TEXT="查询roadmap在500m范围内的lanes" ID="a35e51c071eb4c1bc9e0fe1537d2297d" STYLE="fork"/>
            <node TEXT="遍历lanes，构建lane的语义信息" ID="79f27d1a341a512e3960c390e6d96627" STYLE="fork">
              <node TEXT="建立前驱、后继的关系" ID="21dffe7808768777d180ca12282f5b8f" STYLE="fork"/>
              <node TEXT="左右boundary和中心线按照1m采样" ID="494cbfbe32e5e5edcd4644eb316d3750" STYLE="fork"/>
              <node TEXT="更新boundary的cross，lane type，lane turn type，overlap，限速等属性" ID="fdc46d60777447d4bf5e37bf92d23a15" STYLE="fork"/>
            </node>
            <node TEXT="根据lanes的中心线的点刷新kdtree" ID="6516ddba989cc17628d9331237da3fac" STYLE="fork"/>
          </node>
          <node TEXT="更新锥桶数量信息" ID="aafdd06998fcee71ce4ff5d476fe0fd2" STYLE="fork">
            <node TEXT="遍历perception objects" ID="cb936fd24506e5cfb1611fde688d5c8f" STYLE="fork">
              <node TEXT="过滤非cone目标，高速（非urban【道路类型2-6】，非psp）下过滤god only的目标" ID="40959f2abedd72dd796c5fff63dd31b6" STYLE="fork"/>
              <node TEXT="在road map找离cone最近的lane，过滤路肩和应急车道，得到obj相对lane的s（过滤大于300m）, l" ID="2e1dec6e23a3f67b84c0ce01532e2da8" STYLE="fork"/>
              <node TEXT="左车道线的max, min l为左boundary+正负0.3m，左车道为左车道线的max l + 3m" ID="def18d68fa6f0c0408ea5c9464c81768" STYLE="fork"/>
              <node TEXT="右车道线的max, min l为右boundary+正负0.3m，右车道为右车道线的max l - 3m" ID="3f378816f324577a3f3d1e6a8e824ccd" STYLE="fork"/>
              <node TEXT="计算做左/右车道线、左/右车道的锥桶数目" ID="7d768554c8d6ab84fc387d24d5d2e537" STYLE="fork"/>
            </node>
          </node>
          <node TEXT="根据规划的开始时间和perception objects的目标时间戳做运动补偿" ID="9aa678966b713cfae442919da112742f" STYLE="fork">
            <node TEXT="delta_time = 规划的开始时间-perception objects的目标时间戳" ID="5acd2d5958709dc19d5d74c1ce77e816" STYLE="fork"/>
            <node TEXT="若delta_time大于250ms，则不进行补偿" ID="018e8b589ff67830615e6010cb53d609" STYLE="fork"/>
            <node TEXT="obs的yaw rate有效，且大于 0.1 rad/s" ID="a4b884eda30b36bc7f6032cd2233c24a" STYLE="fork">
              <node TEXT="根据CA模型和yaw rate，做obs的heading，velocity，position的补偿" ID="39103bcc7744308437279615a6dfff0a" STYLE="fork"/>
            </node>
            <node TEXT="obs的速度大于0.5m/s" ID="e703d93b255c5e356fdba343d8e75f47" STYLE="fork">
              <node TEXT="找和obs的heading_diff小于36°且距离小于3m的lanes" ID="0059a1007d32accf878d827b5a28a79a" STYLE="fork"/>
              <node TEXT="根据第一个lane，向后找0.5*vel，向前找1*vel生成lane path" ID="093487c0593e9035a27c3361708b3dfe" STYLE="fork">
                <node TEXT="向后找，根据lane的father id递归找直至距离满足0.5*vel的lane path" ID="89ee9cedfdf79498ff2e236ee33630d3" STYLE="fork"/>
                <node TEXT="向前找，根据lane的child id递归找直至距离满足1*vel的lane path" ID="09809d5be7ca391aa42b588ec0a0eeef" STYLE="fork"/>
                <node TEXT="遍历lane path" ID="e0767008bcdb055168f94186a8da0025" STYLE="fork">
                  <node TEXT="遍历path上的lane" ID="fee8c7340fbe3ae32b64298f88f15697" STYLE="fork">
                    <node TEXT="过滤turn方向为向左/向右u-turn的lane所在的path" ID="17c592fef25cc3269f11ef0d4a3a4ba7" STYLE="fork"/>
                    <node TEXT="根据中心线的点算累计长度和累计heading_diff（两点间的heading差）" ID="9c3b92023b6948e59de2533268840035" STYLE="fork"/>
                    <node TEXT="获取累计heading_diff最小的path" ID="1b53e847eb2fa1163a4fe488d6b98a1d" STYLE="fork"/>
                  </node>
                </node>
              </node>
              <node TEXT="根据lane path得到向后/向前的中心线，作为ref lane" ID="5be59e84d7189561ded0f8919529475b" STYLE="fork"/>
              <node TEXT="将obs的位置投影到ref lane上，获取frenet坐标s, l，及曲率和heading" ID="9941fba6331ac43521af0d4f0b02e904" STYLE="fork"/>
              <node TEXT="计算obs的速度、加速度的方向（speed_angle、acc_angle）" ID="037d52e39c9338dcbc5a2305b10464c9" STYLE="fork"/>
              <node TEXT="tangent_acc = acc * cos((acc_angle - speed_angle))" ID="84fd921bee789f462fa04e7beaa2e331" STYLE="fork"/>
              <node TEXT="delta_s = vel * delta_time + 0.5 * tangent_acc * delta_time^2" ID="5d9eccd88330e920b0fde3c2020fa17b" STYLE="fork"/>
              <node TEXT="delta_v = tangent_acc * delta_time" ID="93d261be18b5146df621d325c7f5138e" STYLE="fork"/>
              <node TEXT="补偿后的frenet坐标为：s + delta_s, l" ID="072e6a457ea6a0ce3fb304e9138a377a" STYLE="fork"/>
              <node TEXT="根据补偿后的frenet的s计算ref lane上的笛卡尔坐标x, y及其heading_diff、曲率" ID="2a8e0911210d3fc220c2eaef2cc7005d" STYLE="fork">
                <node TEXT="heading_diff = 补偿后的s所在的ref lane的heading - 补偿前的s所在的ref lane的heading" ID="21d330ace2ec2a847daabeb3a92c6329" STYLE="fork"/>
                <node TEXT="曲率 = heading_diff / delta_s" ID="1d2b0a8b1a7963935b0c9fa7bf85ff54" STYLE="fork"/>
              </node>
              <node TEXT="若曲率小于0.1，则进行obs的heading，velocity，position的补偿" ID="a1c8469d85020bc88f2883ce438f726a" STYLE="fork"/>
            </node>
            <node TEXT="其他，根据ca模型补偿" ID="f36317ef20113e8d452ecfad4b00715a" STYLE="fork">
              <node TEXT="delta_x = vel_x * delta_time + 0.5 * acc_x * delta_time^2" ID="ea36ae40a0c6e39669fa6f6257347455" STYLE="fork"/>
              <node TEXT="delta_y = vel_y * delta_time + 0.5 * acc_y * delta_time^2" ID="90ef0e2a452c6821f3d5fe73f018d42b" STYLE="fork"/>
              <node TEXT="计算obs的速度、加速度的方向（speed_angle、acc_angle）" ID="532d7ae2dd21e28878fea83fb5ce5cf0" STYLE="fork"/>
              <node TEXT="tangent_acc = acc * cos((acc_angle - speed_angle))" ID="a612e5c889d26a4c6862c554c204bda0" STYLE="fork"/>
              <node TEXT="delta_v = tangent_acc * delta_time" ID="a61e78725ebd3e0d43f880ef19060389" STYLE="fork"/>
              <node TEXT="new_v = max(vel + delta_v, 0.0)" ID="a722e572abfb6fd51e10de375bca4d90" STYLE="fork"/>
              <node TEXT="vel_x = new_v * cos(speed_angle)" ID="ec40b8f9cbc583b690298c1ccecbce21" STYLE="fork"/>
              <node TEXT="vel_y = new_v * sin(speed_angle)" ID="7c3ce47a925869c2b768f7222df24d33" STYLE="fork"/>
            </node>
            <node TEXT="并对polygon点进行补偿" ID="563d3d5b88423ef3df7aae6e92207beb" STYLE="fork"/>
          </node>
          <node TEXT="转换自车的历史状态信息，并更新polygon角点" ID="8905451ac7f0d3fec1561cdf928cadc0" STYLE="fork"/>
          <node TEXT="更新obs中的车辆信息" ID="05840254d94947fe3629b92e81cedf41" STYLE="fork">
            <node TEXT="遍历perception obs" ID="104bcad3ecb19e6bbb89dad2a2fe4597" STYLE="fork">
              <node TEXT="高速（非urban【道路类型2-6】，非psp）下过滤god only的目标" ID="896302493ea7f74d0b21410104959d11" STYLE="fork"/>
              <node TEXT="过滤unknown和unknown static类型的目标" ID="7a710bae660c110c627dffd98e6a0531" STYLE="fork"/>
              <node TEXT="过滤初次检测目标（tracking time为0），且速度小于0.5m/s的目标" ID="2ba5dffc61e7c7a6d673e80cb8206f1f" STYLE="fork"/>
              <node TEXT="若obs的类型为car或truck" ID="8c8378ee842eefe6ad19debdf95887f7" STYLE="fork">
                <node TEXT="速度小于0.5m/s，按照静止处理" ID="b4e6401bf0ad3686450646993c8105f8" STYLE="fork"/>
                <node TEXT="否则计算最近5帧的speed diff，计算加速度" ID="4c183511096be9f7317136d232463a56" STYLE="fork"/>
              </node>
              <node TEXT="其他类型的加速度为0" ID="1c5428e3b0f529ad7772fffc387aeb38" STYLE="fork"/>
              <node TEXT="clamp加速度范围 = max(min(加速度, 3.0), -6.0)" ID="d3ed13f58a920566f044fef14c79c00d" STYLE="fork"/>
              <node TEXT="根据历史状态信息，按照10ms增加采样点（b样条3次曲线）" ID="3e5d4ee410fc821afccff67ae03026a4" STYLE="fork"/>
              <node TEXT="找到100m距离内的obs" ID="54fa6f8b9a154c6f8031dc8405d3c615" STYLE="fork"/>
              <node TEXT="更新虚拟障碍物信息" ID="c75888394ae7e746b59b9e6216082b50" STYLE="fork">
                <node TEXT="虚拟障碍物长宽为0.5m" ID="d07a2fd553829964059bb9f9bb017d24" STYLE="fork"/>
                <node TEXT="遍历停止策略" ID="2cf05067bd9258b570a22e0ccb175cf9" STYLE="fork">
                  <node TEXT="增加虚拟障碍物，id为hash值（停止策略类型+停止策略的序号）" ID="c2815e306e81039010e0e09d9043a4d3" STYLE="fork"/>
                </node>
              </node>
            </node>
          </node>
          <node TEXT="根据local map、其他obs、虚拟障碍物、navi path、参考线和历史conflict point生成lane graph" ID="9781f2acdef3e5a1afe4edea1f074ef1" STYLE="fork">
            <node TEXT="将所有obs按照到自车的距离排序（从近到远）" ID="44e32ca688dc676394838d2cadcf183f" STYLE="fork"/>
            <node TEXT="生成所有的lane path" ID="a7c3c268079381da3d5b13e60fba4116" STYLE="fork">
              <node TEXT="遍历obs（包含自车，id为0）" ID="3461699e14d00a6fc51d6d4c3e96f9b3" STYLE="fork">
                <node TEXT="若为静止（速度&lt;0.5m/s），则heading阈值为180°，否则为36°" ID="a3d93474f86d825488809f2f72942df0" STYLE="fork"/>
                <node TEXT="从local map中找heading阈值和距离小于3m的最近的lane" ID="e5d446200027744999f716d6bdba61cf" STYLE="fork">
                  <node TEXT="用kdtree查找" ID="8accf0e75c6848f9c076a11d47127130" STYLE="fork"/>
                  <node TEXT="若为自车，则匹配navi path上的lane" ID="9f8fc1e1bdae666cb9f5638499990f59" STYLE="fork"/>
                  <node TEXT="如果找不到，则放宽heading阈值为90°和距离为5m" ID="12d409f16d59250800da4d640d36198a" STYLE="fork"/>
                </node>
                <node TEXT="增加obs和lane的绑定关系" ID="858ad48739caf615d2db29fdae5e4887" STYLE="fork"/>
                <node TEXT="根据obs的位置，通过当前lane的向前向后找lane path" ID="c0a199c90e96bc31a37489538b061953" STYLE="fork">
                  <node TEXT="向前的距离=max(vel*10s+0.5*acc*10s*10s, 50m)" ID="7ab3786c5495e94b7607a52396512c96" STYLE="fork"/>
                  <node TEXT="向后的距离" ID="aedf338b93e522df2005e0d1c99ff0cb" STYLE="fork">
                    <node TEXT="自车为=max(0.5*vel*10s, 50m)，他车为0" ID="92cc9a5ff3b304d149d8c4623cf95256" STYLE="fork"/>
                  </node>
                  <node TEXT="向后找，根据lane的father id递归找直至距离满足向后的距离的lane path" ID="952257bf64eaa57672f3c3089f3a7f85" STYLE="fork"/>
                  <node TEXT="向前找，根据lane的child id递归找直至距离满足向前的距离的lane path" ID="f62a318f723df9a318ba12e00f770ce9" STYLE="fork"/>
                  <node TEXT="遍历lane path" ID="95d01f586b7a5455eb8b139d89d2b910" STYLE="fork">
                    <node TEXT="遍历path上的lane" ID="2440b8aa1fc5022e79efcc179262b212" STYLE="fork">
                      <node TEXT="过滤turn方向为向左/向右u-turn的lane所在的path" ID="7946f9a77a2ea36bf3f5c381f894efdf" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="将向后向前的lane path拼接起来" ID="504dca912279d91cbfdebcd4d6a7190c" STYLE="fork"/>
                  <node TEXT="若为自车，按照navi path找lanes" ID="155435e36788579e1527108bda227aad" STYLE="fork">
                    <node TEXT="若navi path上的lane为merge(多个father ids)、split(多个child ids)或crossing（overlap为LANE）" ID="75632b978bde17e112a788e375cf4914" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="根据obs的位置，通过当前lane的left lane向前向后找lane path" ID="1f3ef874786b39f1f76e366e1d0bcca4" STYLE="fork"/>
                <node TEXT="根据obs的位置，通过当前lane的right lane向前向后找lane path" ID="22b6d179aeab2ef58a9666db65b5e256" STYLE="fork"/>
                <node TEXT="根据merge点（merge lane中心线的第一个点），向后（100m）找lane path" ID="de2a34230a42080ad0df4101db0b3622" STYLE="fork"/>
                <node TEXT="根据crossing点（crossing lane中心线的第一个点），向后（100m）找lane path" ID="4095cbb5aff240ab6d80e557a10ff0af" STYLE="fork"/>
                <node TEXT="" ID="5e23c33153be9bad44743c359b810339" STYLE="fork"/>
              </node>
              <node TEXT="根据lane的overlap关系，做合并" ID="0ee07180ef56da1fce98b24594e4d9ff" STYLE="fork"/>
              <node TEXT="生成所有的lane path" ID="2d65bdc56c3bcca29e2a218a8f37db2b" STYLE="fork"/>
            </node>
            <node TEXT="生成所有的lane stream" ID="d8112b311da7339165e1bc100dcc93e5" STYLE="fork">
              <node TEXT="更新lane stream信息" ID="23ebd3b8e6ca4d72cfea5fbcbe5ab716" STYLE="fork">
                <node TEXT="" ID="3ebd7bc7dc07c758e73edffcd58224fb" STYLE="fork"/>
                <node TEXT="对每条lane path生成lane stream" ID="638f3a8414cf30d617e1c28c93344c73" STYLE="fork">
                  <node TEXT="自车生成左/中/右三条，按照对应的参考线生成" ID="e99600cd90a31aee94828d231d10eac6" STYLE="fork"/>
                  <node TEXT="遍历lane path上的lane，得到lane和obs的映射关系，并将lane的中心线上的点拼接成一个长lane作为stream的lane" ID="e76ca45154659183748cd1b2827ea8c0" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="更新merge信息" ID="6d94096387a2b2164bb91f56e444634e" STYLE="fork">
                <node TEXT="计算conflict点的信息" ID="f99b04a5be1c7d3b5709e325e6cf8d11" STYLE="fork">
                  <node TEXT="" ID="2429f833d2301403626770deeda37fbf" STYLE="fork"/>
                  <node TEXT="" ID="72865fe35d293ee8a7071c03890cc8d5" STYLE="fork">
                    <node TEXT="" ID="85aba525593edf05068dcd900fc7666f" STYLE="fork"/>
                  </node>
                  <node TEXT="针对obs和自车分别算merge点在各自的lane stream上的start, end点（frenet、笛卡尔坐标），start比end点的s小2m" ID="af96d9fc6d1e291f6ee3496a5fb935b0" STYLE="fork"/>
                  <node TEXT="再以obs的start，end点作为线段，计算自车的start点在其上的垂足及其distance" ID="1d55b058a12e95ca6083f07b539f83b3" STYLE="fork"/>
                  <node TEXT="垂足在obs的线段上" ID="52e992caa391adf824fbd8bc79bce6e0" STYLE="fork">
                    <node TEXT="cos_theta = dot_prod(ego_vec, obs_vec) / (ego_vec.length() * obs_vec.length())" ID="ebd0fc623fff0d6707f8a982158fc4b5" STYLE="fork"/>
                    <node TEXT="default_square_width（默认车辆宽度） =  2.25*2.25m2" ID="18ce05f6d80b440fdc8ff32ae263cd8c" STYLE="fork"/>
                    <node TEXT="buffer_distance = 0.5m" ID="4522458440b5af4fe5e3e1ce61bfb137" STYLE="fork"/>
                    <node TEXT="threshold = 0.5 * sqrt(default_square_width + default_square_width + 2 * cos_theta * default_square_width) +  buffer_distance" ID="a4ba976664bd969b6a5cb1724059f428" STYLE="fork"/>
                    <node TEXT="若distance &gt; threshold" ID="9d97c1d80147f9bc14056516ff0b1fd2" STYLE="fork">
                      <node TEXT="进一步计算自车的end点在obs的线段上的垂足及其distance" ID="d1b8155568df920352df1be2732b275c" STYLE="fork"/>
                    </node>
                    <node TEXT="根据自车的start, end点插值出threshold的s" ID="b248838b6f361cdee4a749adeee33c8a" STYLE="fork"/>
                    <node TEXT="在参考线上根据s得到其笛卡尔坐标" ID="1fde2355ecbd778bb8166c189d25447b" STYLE="fork"/>
                    <node TEXT="根据lane stream的长lane得到其s, l" ID="80c53168a843d0ff3df0f711e5a783de" STYLE="fork"/>
                  </node>
                  <node TEXT="若垂足不在obs的线段上，则根据图示移动ego或obs，移动步长为2m" ID="9168ea696ff42a2e6e3a7fb8db5d827c" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="更新cross信息" ID="0c56bffbed3f0e1a057174ff6d78247d" STYLE="fork">
                <node TEXT="遍历左/中/右三条lane stream上的lane的overlap lanes，计算作为cross info" ID="90bc25dd986d401c57b4d974305158eb" STYLE="fork">
                  <node TEXT="" ID="a35be2c0089305e267459d572ff26ab6" STYLE="fork"/>
                </node>
                <node TEXT="按照ego_lane_begin_point的s进行cross info的排序" ID="8ddd8b43138bc67b567ab622a32a95b6" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="对lane stream按曲率排序" ID="5f7d75625c400356f93414e6abb92c59" STYLE="fork">
              <node TEXT="分别对左/中/右三条lane stream计算曲率并排序" ID="a84272b4a815bc5429d7d6313a2d6cd5" STYLE="fork">
                <node TEXT="遍历lane stream上的obs及其所在的lane streams" ID="fdccf7c542e616ae9b9d30b1320cd1eb" STYLE="fork">
                  <node TEXT="搜索distance = max(vel*10s+0.5*acc*10s*10s, 50)" ID="fcc6ffab77f1fbbc02d4e837f8e6775b" STYLE="fork"/>
                  <node TEXT="遍历lane streams" ID="57fcb87f509bca96027cd0e7e4b23bef" STYLE="fork">
                    <node TEXT="按照步长为2m，计算累计曲率abs" ID="363f042e4664ff0825a0d9c799cbc725" STYLE="fork"/>
                  </node>
                  <node TEXT="遍历lane stream的lane，计算累计ratio" ID="039669397d53dcb6ecf826b27e118ba5" STYLE="fork">
                    <node TEXT="左转车道为5.0" ID="811bd1b2019fcffccd925f68f099a735" STYLE="fork"/>
                    <node TEXT="右转车道为10.0" ID="4909b7fc46ecebe989b721c837b8e890" STYLE="fork"/>
                    <node TEXT="左右u-turn为20.0" ID="73f580b896fa5757c9036323987d63e6" STYLE="fork"/>
                  </node>
                  <node TEXT="曲率=累计曲率abs/搜索distance*ratio" ID="4fd6b6e7ddc26e5e667ecd836ae23ebb" STYLE="fork"/>
                  <node TEXT="按照曲率从小到大排序" ID="7c7b21080ee859cfdbcaac5599fc33a5" STYLE="fork"/>
                </node>
              </node>
            </node>
            <node TEXT="刷新merge路权信息" ID="c6c429495180f482573ac2cb9bf0abb1" STYLE="fork">
              <node TEXT="遍历所有的merge lanes" ID="faec0e09b8ff711af4c07bd40eba51c8" STYLE="fork">
                <node TEXT="若其中有一个lane的左右boundary为VIRTUAL_AUXILIARY_LINE，则无路权" ID="cfadcc257cf2b00af6bf4bb7ce128111" STYLE="fork"/>
                <node TEXT="找到其father lanes，若所有lanes都无路权，则过滤" ID="9b511755733818c49eb35d1e81fc908e" STYLE="fork"/>
                <node TEXT="递归设置father lane的路权" ID="26160294e46c140c570792f8cf5ba2b4" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="刷新merge车道信息（merge点，merge lane id，conflict point，lane change type）" ID="eb655beaab48764ae75f42ef2b9d20c1" STYLE="fork">
              <node TEXT="遍历所有的merge lanes" ID="723688d11ab42cddfec9a9d25ec40fb5" STYLE="fork">
                <node TEXT="获取lane change type" ID="c3a2b18a3a430d016f1d4604353e0f74" STYLE="fork">
                  <node TEXT="若左boundary为VIRTUAL_AUXILIARY_LINE，则为left forward" ID="1b34a2e718719d192122e36d5dc287b1" STYLE="fork"/>
                  <node TEXT="若右boundary为VIRTUAL_AUXILIARY_LINE，则为right forward" ID="84df4d32b2542685bd1ab1d6c1fc881d" STYLE="fork"/>
                  <node TEXT="其他或左右都为VIRTUAL_AUXILIARY_LINE，则为succeeding" ID="aafc8a0267f0040de75cd4cb176b03f6" STYLE="fork"/>
                </node>
                <node TEXT="找到其father lanes，若其中有一个的lane change type都不为succeeding，则过滤" ID="f180c79ff73d860986594dccbe28d173" STYLE="fork"/>
                <node TEXT="递归设置father lane的优先权" ID="8c82801ac456032d8a180165b274ed87" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="刷新split车道信息（split点，split lane id，lane change type）" ID="fe5618fb476e72cb079e052c5455a410" STYLE="fork">
              <node TEXT="遍历所有的split lanes" ID="6f8f946426b1d7eb448b936e8d5e061d" STYLE="fork">
                <node TEXT="获取lane change type" ID="ba60651bb2e0a94b100401c14961c099" STYLE="fork">
                  <node TEXT="若左boundary为VIRTUAL_AUXILIARY_LINE，则为right forward" ID="bc0e0f4e59a6b62283ec8a323fbb39bc" STYLE="fork"/>
                  <node TEXT="若右boundary为VIRTUAL_AUXILIARY_LINE，则为left forward" ID="0e15a74d301a974690487cc973cfd886" STYLE="fork"/>
                  <node TEXT="其他或左右都为VIRTUAL_AUXILIARY_LINE，则为succeeding" ID="445ee5276c5b906c44bdae6a613e5b9d" STYLE="fork"/>
                </node>
                <node TEXT="找到其child lanes，若其中有一个的lane change type都不为succeeding，则过滤" ID="a6eae9e27c979e195663fdd14df3d901" STYLE="fork"/>
                <node TEXT="递归设置child lane的优先权" ID="55e0210d80f1ab0c0b8e3bd7ab107ee8" STYLE="fork"/>
              </node>
            </node>
          </node>
          <node TEXT="更新obs和lane map关系" ID="c0d5c5b76be2e4c0fdf23154aefdc3da" STYLE="fork">
            <node TEXT="根据obs的信息（id, 状态, 长宽, local map及其lane graph）生成obs的lane map信息" ID="9d84e353cdd9759b5860bb676922fd98" STYLE="fork">
              <node TEXT="向前的距离=max(vel*10s+0.5*acc*10s*10s, 50m)" ID="2311492cab3f58aa98a33973ce836df4" STYLE="fork"/>
              <node TEXT="向后的距离" ID="779518102726ded3fc446acce17d4487" STYLE="fork">
                <node TEXT="自车为=max(0.5*vel*10s, 50m)，他车为0" ID="cc99b5ea87a56f5bfcc95426676ee228" STYLE="fork"/>
              </node>
              <node TEXT="若为静止（速度&lt;0.5m/s），则heading阈值为180°，否则为36°" ID="8923ee3cb89b5259d737e9cf88f770c3" STYLE="fork"/>
              <node TEXT="生成空间属性" ID="c78af1701a4879a0a063666c9ef27552" STYLE="fork">
                <node TEXT="从local map中找heading阈值和距离小于3m的最近的lane" ID="6fd68f10b2f6337584bd5ec95896cf1b" STYLE="fork">
                  <node TEXT="用kdtree查找" ID="429598449bba4d585079fb0ecd267a3d" STYLE="fork"/>
                  <node TEXT="若为自车，则匹配navi path上的lane" ID="9e4db3f3670be3430f29bc9fe7c10e8e" STYLE="fork"/>
                  <node TEXT="如果找不到，则放宽heading阈值为90°和距离为5m" ID="210b0cf948f0b1de23f1a646eb24613e" STYLE="fork"/>
                </node>
                <node TEXT="若为自车" ID="12d425e293a2b8fa1e9adf87b15dbaa9" STYLE="fork">
                  <node TEXT="遍历navi path，找到最近的lane所在第一条的path，得到lane之后的lane的path" ID="d75949c581f590a5d793113e8c669728" STYLE="fork"/>
                  <node TEXT="后找最近的lane的前驱lane，得到多条lane path" ID="bd557cfb6e6c694e39e85d8fa658a62c" STYLE="fork"/>
                  <node TEXT="对lane path去重" ID="6dbbc6dcd38ae832a1a5e587de8295a4" STYLE="fork"/>
                </node>
                <node TEXT="不为自车" ID="dad418f9e9b83380d4e2e0d8586c1583" STYLE="fork">
                  <node TEXT="根据obs id和lane获取lane stream（左中右）" ID="e7d7c2e96833b9679cc62b51ecb22fa8" STYLE="fork"/>
                  <node TEXT="向前向后获取lane id path（按照s计算距离）" ID="936dcc13a945ade05bf9e80f8ff179f6" STYLE="fork"/>
                </node>
                <node TEXT="根据obs的位置、长宽、heading计算角点" ID="1f02ae4b66b9678e930ee335065cf49e" STYLE="fork"/>
                <node TEXT="对每个角点获取heading阈值为PI和距离小于1.5m的最近的lanes作为occupy lanes" ID="34f53e1c9182e825c60ce95bbbff8981" STYLE="fork">
                  <node TEXT="用kdtree查找" ID="23518df71fe9d5a081d483f4b0e8b620" STYLE="fork"/>
                </node>
                <node TEXT="更新左右lane change信息" ID="c9f4b5c7577bea3cf8c901cdfbad2f80" STYLE="fork">
                  <node TEXT="若左/右侧lane类型不为路肩，则为左/右侧可变道" ID="66a8dd97bcfe19b38cb0f2be45d94e33" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="生成lane属性" ID="0b31c043b7634c61db4fdb5af32b19bb" STYLE="fork">
                <node TEXT="根据位置得到frenet坐标s, l" ID="971d29519f1955cf0b4ecf40c1424a25" STYLE="fork"/>
                <node TEXT="根据s得到曲率，车道宽度（左右boundary），heading" ID="38630d055cda050bc52d8d340264ac67" STYLE="fork"/>
                <node TEXT="通过lane graph根据obs id，left lane得到left lane stream及其中心线lane" ID="35066196a10b2ad0bdea875fc1f89339" STYLE="fork"/>
                <node TEXT="通过lane graph根据obs id，right lane得到right lane stream及其中心线lane" ID="14534a62e8c5475b9ca8f5b973d966af" STYLE="fork"/>
              </node>
              <node TEXT="针对自车所有的cross计算路权" ID="2a7740509807d5c910e294b3df86b47c" STYLE="fork">
                <node TEXT="根据traffic sign计算，暂无" ID="736ab96f49da04a4fb9ce674ba6cb31c" STYLE="fork"/>
                <node TEXT="计算ego_lane和cross lane之间的路权" ID="f0341d531a7979ca6fb8f3bfa1510204" STYLE="fork">
                  <node TEXT="首先是否彼此互为overlap" ID="fd73bb2f69736715cf761ac5099c3596" STYLE="fork"/>
                  <node TEXT="根据turn类型确定优先级，进一步确定路权" ID="bd40b75fafd47830c97f8dc4019db96f" STYLE="fork"/>
                </node>
                <node TEXT="根据相对位置计算路权" ID="e9a92270f64b4e7d9e56c865d77a3692" STYLE="fork">
                  <node TEXT="将ego_lane上的点投影到cross lane上" ID="ec6cb142edaecdaac50a80a5c2d76f38" STYLE="fork"/>
                  <node TEXT="投影点的l &gt; 0，则低路权，l &lt; 0，则高路权" ID="8b222f4634b42ab80927b60efcba8623" STYLE="fork"/>
                </node>
              </node>
            </node>
          </node>
          <node TEXT="更新虚拟obs和lane map关系" ID="5fabdf114caa06e959c58ea40f6f151e" STYLE="fork">
            <node TEXT="根据obs的信息（id, 状态, 长宽, local map及其lane graph）生成obs的lane map信息" ID="085bf4f882d4a0cf161431c0e42efe1f" STYLE="fork"/>
          </node>
          <node TEXT="根据自车参考线生成参考lane" ID="45c6b19e5594669e3cd60993e6a84b22" STYLE="fork"/>
        </node>
        <node TEXT="更新lane change信息" ID="e5c31fdc3519f3836633a7b3a90bd4dc" STYLE="fork">
          <node TEXT="取中间ref lane" ID="008ebb5706a01f60d829128311ba3a2b" STYLE="fork"/>
          <node TEXT="获取自车当前位置的frenet坐标s, l" ID="5d2264dce87db448d000b7de3ba65e93" STYLE="fork"/>
          <node TEXT="若l &lt; 0.5m，则是lane keep，否则为lane change" ID="85cdd17c3490b9874e1362ccca590dae" STYLE="fork"/>
        </node>
        <node TEXT="根据route（参考线）更新lane change信息" ID="17573e7df03c03794a3261f9c8b41eaa" STYLE="fork">
          <node TEXT="根据自车的lane map的第一个split点信息的lane change type，选择boundary，并计算自车到boundary的距离，若距离大于（0.5车辆宽度+0.3m），则认为会进入split" ID="b20c7097675d259d2e71b52c0049393a" STYLE="fork"/>
          <node TEXT="自车在变道中，根据向左/右变道，判断是否过变道折回点" ID="350d810ae64a12179487f8703c37669b" STYLE="fork">
            <node TEXT="折回点为前轮是否过左右车道线boundary" ID="4c46cec81a076e9177efa473442c6052" STYLE="fork"/>
          </node>
          <node TEXT="获取自车到merge/split点的距离s" ID="f6a4863b9bbd3d5800a0b6662b1b13a7" STYLE="fork"/>
          <node TEXT="根据变道状态判断是否merge结束（变道的lane id和merge点的lane id对比）" ID="4bb8a6243d88c9775240183cfd67f8e0" STYLE="fork"/>
          <node TEXT="获取到下匝道split的变道次数" ID="c45000b179c3eff0637cec3270169e69" STYLE="fork">
            <node TEXT="遍历route上的lane segment" ID="765b1329612e3b9c358e2ac4cdceffb6" STYLE="fork">
              <node TEXT="lane的后继大于1个，且后继中的lane type为left/right减速车道，则增加lane change计数，直到下匝道或者上匝道（lane type为OFFRAMP或ONRAMP）为止" ID="d174ac492c2b06d734e095eb9d71913a" STYLE="fork"/>
            </node>
            <node TEXT="若left/right的route的优先级高于current，则在最高优先级的route上获取到下匝道split的变道次数" ID="e1bad7fc7b075bdf8ffde5ca102c3f96" STYLE="fork"/>
            <node TEXT="下匝道split的变道次数为1则为最靠近下匝道的车道" ID="dc486897c61695cf1f7304caf1b06e01" STYLE="fork"/>
          </node>
          <node TEXT="获取route position所在的lane是否为最右侧车道" ID="a7ad6d2240398a46125b6bb2a3752735" STYLE="fork"/>
          <node TEXT="" ID="9e18b45e429b56d1e7ce20c5e7bf2d6b" STYLE="fork"/>
        </node>
        <node TEXT="计算route终点的距离" ID="3da2ffa3dc096ed7825a739f99029b8d" STYLE="fork">
          <node TEXT="当且仅当local route的来源为EGO_HDMAP" ID="8504bdd0a1429d9a1a5a4cf1c861f5c8" STYLE="fork"/>
          <node TEXT="若为最靠近下匝道的车道或当前为Freespace规划器，则不受终点约束" ID="68f71f8b614b6b578efba22ba7281cf7" STYLE="fork"/>
          <node TEXT="若target route有效，则使用target route匹配参考线的current/left/right route" ID="3ca092d676a68c36bc7127e414536159" STYLE="fork"/>
          <node TEXT="否则使用current route匹配参考线的current/left/right route" ID="4cbdf49b0a7e0537a797f2e6033a7e47" STYLE="fork"/>
          <node TEXT="得到route上的route position，并根据route length - route position.s计算剩余距离" ID="fe445e7d0c319c981bab194b5825b9b9" STYLE="fork"/>
          <node TEXT="若剩余距离小于150m，则做终点抑制，大于160m，解除抑制" ID="891f71387090bce95b738d9375c5623d" STYLE="fork"/>
        </node>
        <node TEXT="更新到odd边界的距离，并做WTI" ID="d3b7302f5cf5e8d26bd0101a3add9d4f" STYLE="fork">
          <node TEXT="若target route有效，则使用target route，否则使用current route" ID="7325bdc9c53210d2c5cc19d5030de9d4" STYLE="fork"/>
          <node TEXT="通过route的end lane的后继递归，若为TOLL_LANE或CHECKPOINT_LANE，则不满足odd退出" ID="37d422178bc76ce4516bf0828af1596b" STYLE="fork"/>
        </node>
      </node>
      <node TEXT="运行" ID="fe1e1828ea4044a2ceac891ea12c748f" STYLE="fork">
        <node TEXT="变道抑制" ID="c6524727aeb28dd431c2cd181734133b" STYLE="fork">
          <node TEXT="根据锥桶的分布做响应的变道抑制" ID="b30e0543ede86cd39790e05b13e4dfc9" STYLE="fork">
            <node TEXT="本车道前方锥桶数大于2，左右boundary的锥桶数大于3，但旁车道无锥桶，此时不抑制变道" ID="3cf48c8f532e7bffcb6a5d513fb6f14f" STYLE="fork"/>
            <node TEXT="本车道前方锥桶数大于3，左/右旁车道的锥桶数大于3，旁车道的第一个锥桶距离和本车道的第一个锥桶距离相差&lt;20m，则抑制变道" ID="8abad38aacb3e8f1baf5564363f08856" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="AttentionPlan" ID="6da312a7cd032697db3bbc61eaf2b1bd" STYLE="fork">
          <node TEXT="关键目标筛选" ID="7745f85323cbaa7a4639fe1e95ee8a81" STYLE="fork">
            <node TEXT="高速（非urban【道路类型2-6】，非psp）场景" ID="2172a1c26555ecb315d1791ca85abb48" STYLE="fork">
              <node TEXT="通过lane的拓扑连通性选择关键目标" ID="b567ef0d53c2c12c83a9ce7480fd2d6d" STYLE="fork">
                <node TEXT="根据自车的lane map按照自车lane change状态得到自车的多条lane path" ID="29d54925407919c85d9b7ebb1de63358" STYLE="fork"/>
                <node TEXT="" ID="f0aad2b38fe19be59f60790f3786ec62" STYLE="fork"/>
                <node TEXT="根据自车的多条lane path得到其关联的obs作为关键目标" ID="93374740700462d3fb0c147a99af9cd8" STYLE="fork"/>
                <node TEXT="得到自车前方的obs作为关键目标" ID="7f9b425ec6fb390475fa70ad52d20789" STYLE="fork"/>
                <node TEXT="获取自车后方的obs" ID="0447fceca7532105c6a4b467bfe4d5a9" STYLE="fork">
                  <node TEXT="相对速度（obs快于自车）大于2m/s以上" ID="ef01ed988f7e215e06de748ab29f0944" STYLE="fork"/>
                  <node TEXT="roi_distance = distance - 相对速度*5s" ID="0d2427a4e16444e94c650a272ad6ec0e" STYLE="fork"/>
                  <node TEXT="若roi_distance小于15m，则作为关键目标" ID="8ade845a5b683541f7bf1fd81368c74f" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="通过cross选择关键目标" ID="92c36ca113d91545984543193a80ca09" STYLE="fork">
                <node TEXT="遍历obs" ID="a4a765d8bf1adb9eb9fbda231cbbdc00" STYLE="fork">
                  <node TEXT="若不在自车前方，则忽略" ID="5f9b93439b22f6c3740d35fecf8c561f" STYLE="fork">
                    <node TEXT="计算自车和obs的位置的方向向量，然后和自车的heading比，大于90°忽略" ID="8d30fd8c261651d9f50905c4a41deab3" STYLE="fork"/>
                  </node>
                  <node TEXT="分别根据cv模型，计算10s位置的线段" ID="69a835717f5e147a654330b27d90b069" STYLE="fork"/>
                  <node TEXT="判断是否相交，若相交，则作为关键目标" ID="019ff3b0104534e265da422898aa8350" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="通过fov选择关键目标" ID="7baf24b533ba092bf86c6cf7316b62af" STYLE="fork">
                <node TEXT="计算自车和obs的位置的方向向量，然后和自车的heading比，diff大于15°忽略" ID="90ca38e7af17c46e69c4993145aa7fab" STYLE="fork"/>
              </node>
              <node TEXT="后方慢车过滤" ID="d12bf0ed9452be81b09c1f46ae7cdfb5" STYLE="fork">
                <node TEXT="后方慢车，相对速度小于-6m/s，忽略" ID="9d2c75dc31b1ecb00dd2064eeae7378d" STYLE="fork"/>
              </node>
              <node TEXT="按左侧boundary过滤" ID="581df686feda7e88b32ee3745c19b3eb" STYLE="fork">
                <node TEXT="遍历obs" ID="3f94fa061ee59b15ac90589addf52a30" STYLE="fork">
                  <node TEXT="速度小于1.5m/s忽略" ID="d2c1230231f06c607d36e24e2ac47df8" STYLE="fork"/>
                  <node TEXT="找到obs所在lane的最左侧车道，其可跨越属性为physical not或legal not" ID="4e82f5c46e7f9aac2f3eaa91016989ea" STYLE="fork">
                    <node TEXT="逆向运动的目标（计算自车和obs的位置的方向向量，然后和自车的heading比，大于90°且车速大于20kph）过滤" ID="6f760959c3056888e92ea52ff3301550" STYLE="fork"/>
                  </node>
                  <node TEXT="对目标2, 5过滤" ID="fcbfd884aa2d350ed7fc5ceea523b718" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="按地图外过滤" ID="a27e4ba8a87b375353d78f52f1da6171" STYLE="fork">
                <node TEXT="obs没有关联的lane" ID="259fecf29ad19aab5b0391093af55b57" STYLE="fork"/>
              </node>
              <node TEXT="按物理边界过滤" ID="f25c95cae24031d2363dfc3da4902bf7" STYLE="fork">
                <node TEXT="遍历自车的lane map及其lane path" ID="ca3809bc0da319bd79bf4a9c7c824caf" STYLE="fork">
                  <node TEXT="找到每条lane的最左/右lane" ID="6eb410c14d94be31fda0b5f3fddb6ff0" STYLE="fork"/>
                </node>
                <node TEXT="遍历obs" ID="80635206b02ff76fe5df9d08233a33f4" STYLE="fork">
                  <node TEXT="速度大于1.5m/s忽略" ID="70aa0ff70205dc58f6b49280875e8c20" STYLE="fork"/>
                  <node TEXT="针对radar/lidar only的目标过滤" ID="a9f3255ac6aae62feb97cbc00faa1739" STYLE="fork">
                    <node TEXT="根据obs的位置、长宽及heading计算polygon" ID="828b62ccc130be34084d96d158256f40" STYLE="fork"/>
                    <node TEXT="若左右边界类型为physical not，且和obs的polygon相交，则过滤" ID="a7ad4679708d1270a42126246bd86497" STYLE="fork"/>
                  </node>
                </node>
              </node>
            </node>
            <node TEXT="urban或psp场景" ID="bb7e6339a55eae56f3637be9d4811503" STYLE="fork">
              <node TEXT="按照参考线（本车道/左车道/右车道前后）增加obs作为关键目标物" ID="c9701c3fd1658fde20921f50939de377" STYLE="fork"/>
              <node TEXT="通过cross选择关键目标" ID="48a9779508429503a473d64a9a9c9fce" STYLE="fork"/>
              <node TEXT="urban only，按左侧boundary过滤" ID="e23de52eee1ec35f93f8a08eeb9ed69f" STYLE="fork"/>
            </node>
            <node TEXT="增加自车lane map的cross信息关联的目标物作为关键目标物" ID="4967c9b03c6349604a24b2e7fa1a4d5a" STYLE="fork"/>
            <node TEXT="增加自车lane map的merge信息关联的目标物作为关键目标物" ID="98f791fc8868adfb43999e980ad9f217" STYLE="fork"/>
            <node TEXT="对逆向车道的obs进行过滤" ID="7c7ca30a957b68a18226f44201940697" STYLE="fork">
              <node TEXT="速度大于1.5m/s忽略" ID="52ba7179ae16d4a593cae908dd6fd0ee" STYLE="fork"/>
              <node TEXT="逆向运动的目标（横向不在本车道内【左/右侧边缘在左/右侧车道线外】，计算自车和obs的位置的方向向量，然后和自车的heading比，大于90°且车速大于20kph）的过滤" ID="420e420c3161fd2de293b1d2396bdb8d" STYLE="fork"/>
            </node>
            <node TEXT="增加pedestrian和bike类型目标作为关键目标物" ID="55d7a886abea887a34ab77191530f3b1" STYLE="fork"/>
          </node>
          <node TEXT="更新obs的relationship" ID="858b6f56a92fd4891661e294fa828471" STYLE="fork">
            <node TEXT="根据lane stream及其关联的obs增加front, back, left side, right side的相对关系" ID="30a32f62efc152b110f22cc274963d15" STYLE="fork"/>
            <node TEXT="计算merge的obs" ID="a13384ea96214a9cd4c4bc41d3a20c66" STYLE="fork">
              <node TEXT="根据obs所在的lane map找lane stream array" ID="dce9a8dc20b07331fc14b8fe9d28a9c0" STYLE="fork"/>
              <node TEXT="遍历lane stream array，找所有在merge点之后的obs" ID="f1c2ece83ffb40ad9dfeb2a9281d53c2" STYLE="fork">
                <node TEXT="根据lane stream找到所有关联的obs" ID="adbe6e4512d0ce46e5d5cdc022f250b0" STYLE="fork"/>
                <node TEXT="若obs的heading和lane的angle相差超过45°，则过滤" ID="6cabe4fba1b4f1dcd89fe7effc6a6e4a" STYLE="fork"/>
                <node TEXT="若obs的横向位置减去0.5车宽大于半个车道宽度（3.5m），则过滤" ID="8c41345736eb7b9fc073c2414d2f566b" STYLE="fork"/>
                <node TEXT="计算obs的角点，少于1/4的角点在车道内（小于半个车道宽度【3.5m】），则过滤" ID="3bf794ef79c412c39cce0eeda71e574f" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="计算cross的obs" ID="6e2e2d3a74b765d58e7d9d01f164329f" STYLE="fork">
              <node TEXT="根据obs所在的lane map找lane stream array" ID="cc9ca97ec3c5945997de1d0c43a818d6" STYLE="fork"/>
              <node TEXT="遍历lane stream array，找所有在cross lane end point之后的obs" ID="eca52dda5245159c13694ea8848e334e" STYLE="fork">
                <node TEXT="根据lane stream找到所有关联的obs" ID="6e3ce674b81702b3acb8beb3ed029ab9" STYLE="fork"/>
                <node TEXT="若obs的heading和lane的angle相差超过45°，则过滤" ID="79c7fa90670a1a33599d33e0f00607e8" STYLE="fork"/>
                <node TEXT="若obs的横向位置减去0.5车宽大于半个车道宽度（3.5m），则过滤" ID="72296b990ba3c205b5c2b2a706cee95a" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="若为自车" ID="336bbbefe528b4d31a3cfbf6629732bb" STYLE="fork">
              <node TEXT="左/右侧lane stream按照横向距离5m获取obs" ID="4013cf7e714694c6671e9b28437a7693" STYLE="fork"/>
              <node TEXT="考虑nudge，中间ane stream按照横向距离12m获取obs" ID="47f44e17749e67077564e3f84a804bfd" STYLE="fork"/>
            </node>
          </node>
          <node TEXT="Attention规划" ID="6193dfb5c6f6cdb3233a1100606852a3" STYLE="fork">
            <node TEXT="特征提取" ID="bb8d14f6c1ce126250cad297c1dcf676" STYLE="fork">
              <node TEXT="更新obs的历史笛卡尔系的特征（大于15帧的obs）" ID="0442301be1342e4cf3b34259c5996faa" STYLE="fork">
                <node TEXT="" ID="a6aa03dc14ade295247bb0c6c4065701" STYLE="fork"/>
                <node TEXT="obs最新的pos作为中心点，做历史特征的转换（考虑heading）" ID="6c740dcb01e60f2bbd4e623eef0cf5ce" STYLE="fork"/>
              </node>
              <node TEXT="更新obs的历史frenet的特征（最多15帧）" ID="bf2c79d1e2a868605c64bae7c1f542af" STYLE="fork">
                <node TEXT="" ID="b489e6e9dce2a2b64971abc4c21ef396" STYLE="fork"/>
                <node TEXT="obs的lane map的中间车道作为目标车道" ID="da9e08cf5df9b19e6d066c414f7085a9" STYLE="fork"/>
                <node TEXT="将历史特征投影到目标车道，得到s, l，theta，curvature，lane width等，并针对vel, acc进行计算" ID="bfc87c8c93d706c8331794cec688c4e1" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="生成obs的intention" ID="b94a46154875f9daec53e90c402ed254" STYLE="fork">
              <node TEXT="使用决策模型计算obs的intention" ID="cd47d76a4feac397acc8f29de71bddd1" STYLE="fork">
                <node TEXT="取第一条参考lane作为目标车道" ID="e2f121497e89cf2c6c0fa03b58915300" STYLE="fork"/>
                <node TEXT="获取自车当前位置的frenet坐标s, l" ID="2efe2b157df2fdf1d180ccb591d1c8bb" STYLE="fork"/>
                <node TEXT="若l小于0.4m，则自车为lc" ID="b57d211d43da9b610dcb13a88bfc5e3c" STYLE="fork"/>
                <node TEXT="若是lc，则执行单车道决策" ID="a071e5dc9568a5a6acdf6ae25556dc25" STYLE="fork">
                  <node TEXT="进行特征提取" ID="831789dd34b40df7595d635b771dc5db" STYLE="fork">
                    <node TEXT="更新obs的历史笛卡尔系的特征（10帧的obs）" ID="616ed072246864e633f79a81d90c83b4" STYLE="fork">
                      <node TEXT="" ID="e36121b207ebda6b4cb13ccb62677a2c" STYLE="fork"/>
                      <node TEXT="自车最新的pos作为中心点，做历史特征的转换（考虑heading），speed和acc都为相对自车的" ID="8547934a8f9547b048459602780235eb" STYLE="fork"/>
                    </node>
                    <node TEXT="更新obs的历史frenet的特征（10帧的obs）" ID="82f9b71504ac10b365498f5a7cd4dc30" STYLE="fork">
                      <node TEXT="将历史特征投影到目标车道，得到s, l，theta，curvature，lane width等，并针对vel, acc进行计算" ID="0b357b1c82b0afc94b7e20f5ec28efd0" STYLE="fork"/>
                      <node TEXT="忽略s在280米以外的历史特征" ID="8c7286a960f816f986ec28feb97d34a6" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="模型推理" ID="64d788e4b55f48c6a926bff932234656" STYLE="fork">
                    <node TEXT="open lane keep模型" ID="38077fecb88c6eaeb89b1218ca740f6b" STYLE="fork">
                      <node TEXT="模型推理输入" ID="2e8e474233411eba040003ae3594542f" STYLE="fork">
                        <node TEXT="取历史状态中最新的一个作为输入" ID="21fd2b9ba83061e014487d6cd791845d" STYLE="fork"/>
                      </node>
                      <node TEXT="模型后处理" ID="3079e165c9facffeff8e7f28108af3de" STYLE="fork">
                        <node TEXT="obs的概率大于0.6，则为YIELD，否则为NOT_YIELD" ID="a785c10bea91a194a0a87188ac83efd3" STYLE="fork"/>
                      </node>
                    </node>
                    <node TEXT="时序模型" ID="fe7782a342feac064526a898044a36c9" STYLE="fork">
                      <node TEXT="模型推理输入" ID="2aaf02283611ff425abda8293a0ee697" STYLE="fork">
                        <node TEXT="对obs按s进行排序，找离自车近的最多8个目标，每个目标10frame状态" ID="f17e97aad44d8fb3b88ee43c0133ac4c" STYLE="fork"/>
                        <node TEXT="" ID="dccd8d1c4bdf34a4add00b30f7b6e9c2" STYLE="fork"/>
                      </node>
                      <node TEXT="模型后处理" ID="97e565952f455838a09dfe91d58b7b9b" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="虚拟lane的规则模型" ID="3f20b99b0d1afb7a9ed74fc4372e6156" STYLE="fork">
                    <node TEXT="遍历关键目标物" ID="275b43b54b6a0daefb5e58c7ca34ddd7" STYLE="fork">
                      <node TEXT="计算其角点的l及绝对值最小的l" ID="bd2992c5f25ca111a690f9c9c908b320" STYLE="fork"/>
                      <node TEXT="计算其角点相对自车的l及绝对值最小的l" ID="f0f629c2be1e78926eb80455015a61fb" STYLE="fork"/>
                      <node TEXT="" ID="70e9d104ce1e7d12455c3d39dcc2592a" STYLE="fork"/>
                      <node TEXT="" ID="68ad8664ed242188cf9785afaf3159bb" STYLE="fork"/>
                      <node TEXT="" ID="9809cad36fd67fed50edf7e3e490663a" STYLE="fork"/>
                      <node TEXT="根据类别和自车车速选择concern area和core area" ID="0601213c37a3a7f699225011473f1217" STYLE="fork">
                        <node TEXT="car类型obs（4/5），buffer为0.3m, compress为0.32m, extend为1m" ID="611066026bd6af31f9eff2355c108533" STYLE="fork"/>
                        <node TEXT="truck类型obs（6），buffer为0.2m, compress为0.65m, extend为1m" ID="22eca1fc08a4f978b849ebc31b1f7ac5" STYLE="fork"/>
                        <node TEXT="其他类型obs，buffer为0.1m, compress为0.8m, extend为0.1m" ID="06b78c23fca1c9916b20653adf382113" STYLE="fork"/>
                        <node TEXT="根据自车到左右边界的l" ID="74188fcc5f8d8fa08aa4525222444421" STYLE="fork">
                          <node TEXT="大于自车0.5车宽或0.35车宽" ID="032c08747908f903a2bf72dedc0cfadb" STYLE="fork"/>
                          <node TEXT="大于自车0.25车宽" ID="1e398fe3fde5ca03e7756146673d8614" STYLE="fork">
                            <node TEXT="根据速度方向和l_v确定concern area" ID="c60d90c8672f9a9190f35d231a627e45" STYLE="fork">
                              <node TEXT="车速&lt;-0.45m/s，则R width = max(0.5自车车宽+buffer, abs(自车l) + min(右边界的l, 2.5m) - compress" ID="f4cc40b44747c8d2ab34e8a12f496b90" STYLE="fork"/>
                              <node TEXT="车速&gt;-0.45m/s，则R width = max(0.5自车车宽+buffer, abs(自车l)  - compress" ID="cf1db5b9d8e9697540d80d3ffcaedc63" STYLE="fork"/>
                            </node>
                          </node>
                          <node TEXT="左右边界外" ID="946f1b14c1903d0fd24e778d5ef9255a" STYLE="fork">
                            <node TEXT="根据横向速度方向和l_v确定concern area" ID="323d21546f9ba74581cd254f4050003e" STYLE="fork">
                              <node TEXT="车速&lt;-0.45m/s，则R width = max(0.5自车车宽+buffer, abs(自车l) + min(右边界的l, 2.5m) - compress" ID="ad89eb19b94a173a5988e14fc3172011" STYLE="fork"/>
                              <node TEXT="车速&gt;-0.45m/s，则R width = min(max(0.5自车车宽+buffer, abs(自车l)  - compress, 0.5自车车宽+extend)" ID="208e979a6dda86ab55b188eb1b055916" STYLE="fork"/>
                            </node>
                          </node>
                          <node TEXT="左右边界内，中心线左/右侧" ID="7bd4d5d7596e3297a11aa8e01ce5fe60" STYLE="fork">
                            <node TEXT="根据速度方向和l_v确定concern area" ID="d21df36989871d7e28bb2db0a21df1b6" STYLE="fork">
                              <node TEXT="车速&lt;-0.2m/s，则R width = max(0.5自车车宽+buffer, abs(自车l) + min(右边界的l, 2.5m) - compress" ID="e189e884eeda93db5e424def8153bcf5" STYLE="fork"/>
                              <node TEXT="车速&gt;-0.2m/s，则R width = min(max(0.5自车车宽+buffer, abs(自车l)  - compress, 0.5自车车宽+extend)" ID="bdeebac1695b397d5e52a661b0544fc0" STYLE="fork"/>
                            </node>
                          </node>
                          <node TEXT="划分cutin的funnel s：close（0-50m），far（50-250m），far far（&gt;250m）" ID="1fd3bc81cfde460b688bc75076024e0d" STYLE="fork"/>
                        </node>
                      </node>
                      <node TEXT="针对cutin目标的buff" ID="95dbe9341765200849b6cbbf59811b7c" STYLE="fork">
                        <node TEXT="L/R cutin buff = min(ego_l_v, 正负1) * predict_cutin_time * factor_correct * factor_s" ID="0c41b8bc1be439f4e612f16f01cfb2cc" STYLE="fork">
                          <node TEXT="predict_cutin_time（根据abs(ego_l_v)插值）" ID="581bfae3cf15e0b2683ea20d96c70198" STYLE="fork"/>
                          <node TEXT="factor_correct（根据到左右边界的dist插值）" ID="063d2b494396f9f0e4a5d0250a6fcb75" STYLE="fork"/>
                          <node TEXT="factor_s（根据obs的s插值）" ID="4f61f00aa8771cfdd7cd83aed31b032a" STYLE="fork"/>
                          <node TEXT="按0.02（car）或0.05（truck）取min" ID="4f41cc362764659a452b78a76ec4ab77" STYLE="fork"/>
                        </node>
                      </node>
                      <node TEXT="L/R width增加cutin的buff" ID="6f2c4b77786cdd0bd45b7c0b17207246" STYLE="fork"/>
                      <node TEXT="计算obs的concern概率" ID="67816821814b223c1245d7edbc888214" STYLE="fork">
                        <node TEXT="" ID="9eaa5d953f1d9a6ba04f463556d89bf0" STYLE="fork"/>
                        <node TEXT="obs的车尾超过自车车头" ID="07a368bfec2102f93f9a2ab896ad3850" STYLE="fork">
                          <node TEXT="离自车的l小于1.05m【核心区】，则concern prob为1" ID="45b487ecbdc4953350541de68266ec41" STYLE="fork"/>
                          <node TEXT="否则根据s，按照close, far, middle的L/R width插值得到base width" ID="1212dfb36eecd6ff1d660f42cfdf1e5a" STYLE="fork"/>
                          <node TEXT="concern prob = (base width - abs(离自车的l))/(base width - 1.05m【核心区】)" ID="82904d219d81d0c9c4f1ff8dcb9d60af" STYLE="fork"/>
                          <node TEXT="clamp concern prob在[-1, 1]之间" ID="2b2b677d0dfec0fa911d29ce0fdf92b6" STYLE="fork"/>
                        </node>
                      </node>
                      <node TEXT="计算obs的certainty概率" ID="cc8b29362621d3b11d30f4cb86ab0ab1" STYLE="fork"/>
                      <node TEXT="obs的certainty概率超过yiled thresh(0.4)，则为YIELD，否则为NOT_YIELD" ID="3182c62c10d26193875d72dfc2c842b6" STYLE="fork">
                        <node TEXT="对psp做risk detection，并设置为RISK" ID="158250bbdb0aee25b9c218fe49646206" STYLE="fork"/>
                      </node>
                    </node>
                  </node>
                  <node TEXT="nudge的规则模型" ID="4aece3f0bd5ff5aa1e15bfe219a88397" STYLE="fork">
                    <node TEXT="自车纵向速度s_v小于0，则结束" ID="9e2b7064e5605c337d3d3db5bcdd14dd" STYLE="fork"/>
                    <node TEXT="遍历关键目标" ID="88bd46c788e6694cee18bf55d31cc234" STYLE="fork">
                      <node TEXT="忽略非ped, bike, car, truck, cone的目标（3/4/5/6/7）" ID="4fc74b4226d147d0dcc90ea36d9f2d4e" STYLE="fork"/>
                      <node TEXT=" 非psp场景下忽略cone" ID="1695e252f02a1de27edde9538c658d42" STYLE="fork"/>
                      <node TEXT="若obs的s_v大于max(ego的s_v, 1.0m/s)，则忽略" ID="93553c3e80c7eba0e63941280d4d9f8a" STYLE="fork"/>
                      <node TEXT="若obs非静止且yield无危险，则忽略" ID="ac7a0fbd6988b944875c31d415333a0b" STYLE="fork">
                        <node TEXT="obs非静止（速度大于0.5m/s或横向速度l_v大于0.1m/s）" ID="caeb0f1bb0360a8a4f47c1f314ab8ce8" STYLE="fork"/>
                        <node TEXT="yield有危险（纵向速度s_v小于0.5m/s且横向速度l_v大于0.1m/s且和相对自车的减速度&gt;2.5m/s2）" ID="8899defe2ecdb0e6026625a60fd89915" STYLE="fork">
                          <node TEXT="减速度=(ego_s_v^2 - obs_s_v^2)/(0.5*(obs_s - ego_s))" ID="9cf46f5f48bf77e0f124d5d9e4c39e83" STYLE="fork"/>
                        </node>
                      </node>
                      <node TEXT="计算obs的包络s, l，若obs不在目标车道，则忽略" ID="35430742da7ba496741d08ec0c255116" STYLE="fork"/>
                      <node TEXT="得到nudge的方向" ID="7c15b9e25391e9c5f6c4c9b7ece578bc" STYLE="fork">
                        <node TEXT="start_l大于0，则为向右nudge" ID="9bb75edec67ae1ae2260c06aebf7f671" STYLE="fork"/>
                        <node TEXT="end_l小于0，则为向左nudge" ID="51d35e0862313a7cca0986ea66e97b7c" STYLE="fork"/>
                      </node>
                      <node TEXT="计算静态剩余空间=max(左边界-end_l, 右边界+start_l)" ID="0d5ea4e15038086b320e623d56a56986" STYLE="fork"/>
                      <node TEXT="若静态剩余空间小于自车宽度+0.3m（横向安全距离）*2，则忽略" ID="d05eaa57a88dd1f8baa8f0fccdd3d88e" STYLE="fork"/>
                      <node TEXT="计算obs的ttc=dist/(ego_s_v - obs_s_v)" ID="51c1ec6257c9114db5871c2f7944d066" STYLE="fork"/>
                      <node TEXT="计算nudge程度（横向加速度=2*（0.5*abs(横向nudge距离))/ttc^2），若横向 加速度大于0.5m/s2，则忽略" ID="5fc15bd703c12968677a5c74b2b1cc8a" STYLE="fork"/>
                      <node TEXT="计算到vru的横向安全距离" ID="7a72904cd1b347fd334b15746330dcba" STYLE="fork">
                        <node TEXT="计算vru和自车的相对速度vel_diff = max(obs_s_v, ego_s_v) - obs_s" ID="0cc3723fd3cc5d10dc0bf7c6195a2721" STYLE="fork"/>
                        <node TEXT="clamp相对速度在[10, 25]" ID="100580fd3c053b96769437915397636a" STYLE="fork"/>
                        <node TEXT="最小横向安全距离 = 0.3m(静态vru) 或0.7m(动态vru)" ID="96ded6bed7879d412f22b36405082592" STYLE="fork"/>
                        <node TEXT="最大横向安全距离 = 1m" ID="592224d8f0f319ab7ec35bbd01d2be9a" STYLE="fork"/>
                        <node TEXT="(最大横向安全距离 - 最小横向安全距离)*速度因子 + 最小横向安全距离" ID="1c0dd7d5baabf1804829dc885b63593b" STYLE="fork"/>
                      </node>
                      <node TEXT="静态剩余空间小于vru的横向安全距离，则忽略" ID="48991eecc137460f6690406f9094972f" STYLE="fork"/>
                      <node TEXT="根据nudge的方向，选择left side, right side的dyn obs" ID="65a1dfe9b4898b29cde73d07ed03cdd2" STYLE="fork">
                        <node TEXT="计算dyn obs的ttc" ID="e1ef08cddea4d3c29c7ca4ab58a2a887" STYLE="fork"/>
                        <node TEXT="若dyn obs在自车侧前（start s大于自车end s+5m）" ID="267eb9cc18a26e2e7fb97ca27d6d21cb" STYLE="fork">
                          <node TEXT="ego_s_v小于dyn_obs_s_v，则继续" ID="35ebe6bbe966d5af68de6ab7b1c7f92c" STYLE="fork"/>
                          <node TEXT="ego_s_v大于dyn_obs_s_v，dyn obs的ttc &gt; obs的ttc + nudge时长 + buffer(0.5s)，则继续" ID="98f594b08eea6c35b378da214f92da36" STYLE="fork"/>
                        </node>
                        <node TEXT="若dyn obs在自车侧后（end s小于自车start s-5m）" ID="010462e6a859a7ea3a09bbddafeca158" STYLE="fork">
                          <node TEXT="ego_s_v大于dyn_obs_s_v，则继续" ID="c88c46bf06a55d08197c6036369e3712" STYLE="fork"/>
                          <node TEXT="ego_s_v小于dyn_obs_s_v，dyn obs的ttc &gt; obs的ttc + nudge时长 + buffer(1.5s)，则继续" ID="9593756e15992801606a1b6189969d6a" STYLE="fork"/>
                        </node>
                        <node TEXT="计算剩余宽度" ID="e9b368cff5c5b90a2905180064ab8e2a" STYLE="fork">
                          <node TEXT="左侧nudge，则剩余宽度=obs_start_l - max(-右侧边界, dyn_obs_end_l)" ID="2ed12b09f36c548b8e900462be86bd4d" STYLE="fork"/>
                          <node TEXT="右侧nudge，则剩余宽度=min(左侧边界, dyn_obs_start_l) - obs_end_l" ID="ddf7d901f7780bbb178b8e7896de0808" STYLE="fork"/>
                        </node>
                        <node TEXT="剩余宽度不够，则nudge失败" ID="d354ea55d5345af3e789426cfee9f42b" STYLE="fork"/>
                      </node>
                      <node TEXT="对psp做risk detection，得到限速，并设置为RISK" ID="70406e4428ec24c416574fabc0f05d98" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="决策结果合并" ID="b2278924a9adf20ffcddce229d83b4da" STYLE="fork">
                    <node TEXT="nudge优先" ID="ac046081c516b5d39ab0d7d0e246db66" STYLE="fork"/>
                  </node>
                  <node TEXT="合并推理结果（open lane keep模型和时序模型的结果）" ID="2d89c4677c121f7092c433b04223a20f" STYLE="fork"/>
                  <node TEXT="合并决策结果" ID="b61f2dc6c92476223d1f44d5c0599779" STYLE="fork">
                    <node TEXT="自车变道时，使用rule base的决策结果" ID="fbf65e5ede7ca321ba04f658271e858e" STYLE="fork"/>
                    <node TEXT="rule base的决策结果（yield, left nudge, right nudge）优先" ID="baf4ab2f0562d18ce68fb693bd54c203" STYLE="fork"/>
                    <node TEXT="无rule base的决策结果时，使用learning base的决策结果（yield）" ID="290e615dc96e311e3a2e768d5a8b02cb" STYLE="fork"/>
                    <node TEXT="learning base的决策结果为not yield时，使用rule base的保底" ID="6d5bcfd63bb38ebc38ae8ba7fd585210" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="获取goal intention" ID="5678fa1737fcea5d68abdfd087e30705" STYLE="fork">
                  <node TEXT="若获取不到obs的lane map，则intention type为fallback" ID="60f2190bac108768e3ece0ef2937ccc9" STYLE="fork"/>
                  <node TEXT="若决策结果不为yield，则intention type为lane keep" ID="887a029f9dfa45c11e47c1e4680a83eb" STYLE="fork"/>
                  <node TEXT="若obs的l在右边界右侧，且横向速度&gt;0.2m/s，则intention type为lane change left" ID="e578c7a7734087fe1d5d111bcc4027f0" STYLE="fork"/>
                  <node TEXT="若obs的l在左边界左侧，且横向速度&lt;-0.2m/s，则intention type为lane change right" ID="c6dd33f1d58a1ab39df444cce1d6e62e" STYLE="fork"/>
                  <node TEXT="其他intention type为lane keep" ID="af4fadeee9aaa6f07b08e4b096045930" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="使用横向规则计算obs的intention" ID="c80ce932c30a189b74f5b084f4ae1982" STYLE="fork">
                <node TEXT="若获取不到obs的lane map，则intention type为fallback" ID="17b9df4f86ff1ea677edfc521ed47e99" STYLE="fork"/>
                <node TEXT="计算历史（3帧）的平均横向速度和平均angle diff（相对lane）" ID="cebe64cb1ac0600e86201a8be7caa561" STYLE="fork"/>
                <node TEXT="横向distance的thresh = 0.1倍的车道宽度" ID="199fda4af5d01ed57a9e16df34699247" STYLE="fork"/>
                <node TEXT="若obs的lane map向左/右可变道，计算向左/右变道的概率" ID="dd669ace917ae9c7ef9b4fbc1be27430" STYLE="fork">
                  <node TEXT="横向l大于横向distance的thresh且横向速度大于0.7m/s，则左变道的概率为1" ID="fae034e697aaae17cf307c2ee7ed6fe9" STYLE="fork"/>
                  <node TEXT="横向l小于-横向distance的thresh且横向速度小于-0.7m/s，则右变道的概率为1" ID="07a6ca8ca659d582f918e392f30cde0c" STYLE="fork"/>
                  <node TEXT="其他，左右变道的概率为0" ID="e70b097a3769755741fdbb6a215454fc" STYLE="fork"/>
                </node>
                <node TEXT="若左右变道的概率为0，则keep的概率为1" ID="23997032fe1f1b41db0f833cdb497051" STYLE="fork"/>
                <node TEXT="根据概率，得到obs的intention为lane keep或left lane change或right lane change" ID="bba26d81116a35afcece37887d9dd256" STYLE="fork"/>
              </node>
              <node TEXT="使用roi计算vru的intention" ID="97f2520530c4faac4421db34d194cae8" STYLE="fork">
                <node TEXT="根据obs的s获取ego目标车道上的angle，计算heading_diff，若大于正负9°则认为不在roi范围内，则intention type为fallback" ID="adde4688d254c2b9e5a3cc9c32e999fc" STYLE="fork"/>
                <node TEXT="若obs的横向l小于2.5*3.5m且obs在自车车前（obs_s &gt; ego_s + 0.5* ego_length），则intention type为lane keep" ID="6d0199b593784d77651cbdb7ca654f57" STYLE="fork"/>
                <node TEXT="其他，则intention type为fallback" ID="fcff09cbd3f2ce216b33b654544ccfd8" STYLE="fork"/>
              </node>
              <node TEXT="合并goal intention" ID="8b500ba1ca88f23a425dd86d82bc754d" STYLE="fork">
                <node TEXT="vru的intention优先" ID="341128a051f0593e6a57dda30a870c96" STYLE="fork"/>
                <node TEXT="横向规则的intention无效，则忽略" ID="9d92d40bdf71e62a569636638e3af952" STYLE="fork"/>
                <node TEXT="决策模型的intention无效，则按横向规则的intention" ID="b2543c9d4ecfeee69963c11b6d720f5c" STYLE="fork"/>
                <node TEXT="obs的lane map无效，则按横向规则的intention" ID="c1fdfc0eb4344ba015e8ecc2036d9a16" STYLE="fork"/>
                <node TEXT="obs的lane map为逆向运动，则按横向规则的intention" ID="5af0fc56649df8eb941aa2955dde90d3" STYLE="fork"/>
                <node TEXT="决策模型和横向规则的intention都不为lane keep且不一致，则按横向规则的intention" ID="dba6a9a76f4ed938345364315a7afc8a" STYLE="fork"/>
                <node TEXT="决策模型的intention为lane keep，且和横向规则的intention不一致，则按横向规则的intention" ID="1850b20a38cd74e1f64274c5b542ce48" STYLE="fork"/>
                <node TEXT="其他，按照决策模型的intention" ID="81b64b458d9942e5038ca916bd038ef4" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="生成obs的path" ID="8c29fecbef22c62aa6fea2290cd70a78" STYLE="fork">
              <node TEXT="遍历obs的intention" ID="a85a67f916bb1365d086e757b36f7bcc" STYLE="fork">
                <node TEXT="根据intention选择target lane" ID="dfacc1af3fe4745f86737f5dee4db360" STYLE="fork">
                  <node TEXT="intention为left lane change且lane map向左可变道，则left lane为target lane" ID="a881b97839b55262bb804cb3db934c33" STYLE="fork"/>
                  <node TEXT="intention为right lane change且lane map向右可变道，则right lane为target lane" ID="b9be6f7c2cdc69e41effebc02ee085b7" STYLE="fork"/>
                  <node TEXT="否则中间车道为target lane" ID="26027cd908662efb8855e3ecc6d804c3" STYLE="fork"/>
                </node>
                <node TEXT="从0s~14s，间隔2s，使用QuarticPolynomialCurve1d做纵向规划" ID="f10625d4522047027895c94062cb09c3" STYLE="fork">
                  <node TEXT="check纵向轨迹的有效性" ID="74373a9678e42925c535fd9ec1ab7ed1" STYLE="fork">
                    <node TEXT="v在(-0.1m/s, 40m/s)" ID="63241cd30e1ebafd897e290216cca54a" STYLE="fork"/>
                    <node TEXT="acc在(-0.6m/s2, 4m/s2)" ID="bb4828dbe59b5e1f7af776b86fdb1fe1" STYLE="fork"/>
                    <node TEXT="jerk在(-4m/s3, 2m/s3)" ID="0b8d638fcf577d602ff4910ad6140e1e" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="从不同的s（10, 20, 30）使用QuinticPolynomialCurve1d做横向规划" ID="80663770065abc4303ec33a3a06cebf1" STYLE="fork"/>
                <node TEXT="计算cost = 10*lat_comfort_cost + 1* lon_comfort_cost" ID="5346ff2e9386e981ac4c39a7a332702e" STYLE="fork">
                  <node TEXT="" ID="262e42ef27e3b3ec207981542d8629e8" STYLE="fork"/>
                  <node TEXT="" ID="a12f2884595b34eb99dfda98d7ac659d" STYLE="fork"/>
                </node>
                <node TEXT="找到cost最小的横纵向轨迹" ID="efc6b0120cb1a23633de55a8752fe90b" STYLE="fork"/>
                <node TEXT="时间从0到12s，采样0.1s，分别得到每个点的纵向s和横向d" ID="f4fa91de3958c90aa67b224100ebf681" STYLE="fork"/>
                <node TEXT="从target lane上获取每个点的投影点作为参考线" ID="cfa2b0f9c4226fda6bb19517da8ca1d3" STYLE="fork"/>
              </node>
            </node>
          </node>
          <node TEXT="计算obs风险" ID="9c81e385a6131b1fcb2238a7be0fbb19" STYLE="fork">
            <node TEXT="自车不在lane keep，则reset风险obs（risk obs, cutin obs, aware obs）并结束" ID="e2f0f312954e01ee6b126ed323df5841" STYLE="fork"/>
            <node TEXT="非urban且非psp且当前车道非下匝道且参考线大于1条，则进行车流的计算" ID="4069b2865c236024a4a00b78ac5fa3b0" STYLE="fork">
              <node TEXT="计算左/右参考线上的车流" ID="5378091ab11e4a52bedbccfc1218a662" STYLE="fork">
                <node TEXT="非merge场景（左/右参考线的navi path和当前参考线的navi path无交集）" ID="e52687ff5115fe9ec5661bf44f076da6" STYLE="fork">
                  <node TEXT="获取left side, right side的obs" ID="18f35bd461f7d51ff39b495a12089a2b" STYLE="fork"/>
                  <node TEXT="过滤不为car且不为truck的目标" ID="b24c2ed3c8e55af7a03632f52c689672" STYLE="fork"/>
                  <node TEXT="obs的s在(10，150）之间的，作为车流目标" ID="e3e4699f2ab0bc656c8417829d5d6b61" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="计算左/右参考线上的慢速车流" ID="6a922445007a95493cda4d9c251d289a" STYLE="fork">
                <node TEXT="左/右侧车流上升沿（当前左/右侧车流为false）" ID="2951f1907308a4c7164999a22034b3f6" STYLE="fork">
                  <node TEXT="左/右参考线上的车流&gt;=4且持续时间&gt;=2s，则左/右侧车流为true" ID="5213eac903a0b9b569e20fdab5fbbaf3" STYLE="fork"/>
                </node>
                <node TEXT="左/右侧车流下降沿（当前左/右侧车流为true）" ID="dbb168d119cb61078a935bf9ba828a34" STYLE="fork">
                  <node TEXT="左/右参考线上的车流&lt;=2且持续时间&gt;=5s，则左/右侧车流为false" ID="c935d6a7c02594de1a63411e1b5c5f44" STYLE="fork"/>
                </node>
                <node TEXT="若左/右侧车流为true" ID="d14c7facbea2e3bf992d6067eebb5d9e" STYLE="fork">
                  <node TEXT="计算车流的平均车速，并做truck目标的计数" ID="bff5bded5886b7a8e0fffc784feef654" STYLE="fork"/>
                  <node TEXT="车流速度 = 60kph，若truck个数&gt;=2，则车流速度为40kph" ID="bbb474b5aad66a75f47ff06f517156df" STYLE="fork"/>
                  <node TEXT="左/右侧慢速车流上升沿（当前左/右侧慢速车流为false）" ID="7d00f1b788731ed854c8d38e8f852ce1" STYLE="fork">
                    <node TEXT="若自车的set speed - 车流速度 &gt; 60kph且持续时间&gt;=2s，则左/右侧慢速车流为true" ID="2e513811477f07624e18ed69fcfbc3b1" STYLE="fork"/>
                  </node>
                  <node TEXT="左/右侧慢速车流下降沿（当前左/右侧慢速车流为true）" ID="4313d870cd8c71330ee17197c3272635" STYLE="fork">
                    <node TEXT="若自车的set speed - 车流速度 &lt; 10kph，则左/右侧慢速车流为false" ID="61bc4ffacb863bf5a7dc00d220cf01bc" STYLE="fork"/>
                  </node>
                </node>
              </node>
              <node TEXT="计算车流下的目标车速" ID="4ca2cd173a3f801b5efef88d3bca010e" STYLE="fork">
                <node TEXT="获取min(左/右慢速车流车速)" ID="6f95c5d90b9d07a04a18216e4e5ec981" STYLE="fork"/>
                <node TEXT="获取法规限速（highway：60kph, city：40kph）" ID="7eed903c9c0d361ca64c65b6e6944615" STYLE="fork"/>
                <node TEXT="目标车速=max(set_speed - (set_speed - slow_vehicle_flow_speed)/3, min(法规限速, set_speed))" ID="616283b59b845384e7c2a3d38971a4f3" STYLE="fork"/>
                <node TEXT="触发减速或加速的wti" ID="49761e762a28c2913877f32a53133ab9" STYLE="fork"/>
              </node>
              <node TEXT="遍历obs，计算风险信息" ID="1a63f5b9b19f644be97045da7345974a" STYLE="fork">
                <node TEXT="" ID="ea0004de160cbdf582e1a09a95a156d3" STYLE="fork"/>
                <node TEXT="relative_speed = ego_velocity - obs_velocity" ID="7e6e64f0751c6dac94e09c3a9d4c9272" STYLE="fork"/>
                <node TEXT="若relative_speed大于0" ID="e34266d58363580ceddf91bfc5d2e147" STYLE="fork">
                  <node TEXT="relative_speed小于5m/s" ID="9aef7f3a876b675360090e8957bd9aec" STYLE="fork">
                    <node TEXT="jerk_time = sqrt(2* relative_speed / 3.5m/s2)" ID="c38df608dbf610c5437ef31ef9f27541" STYLE="fork"/>
                    <node TEXT="jerk_acc_move_dist = relative_speed * jerk_time - 1/6* 3.5 * jerk_time^3" ID="1191027d6fe891409c22ea3aa13ddddb" STYLE="fork"/>
                  </node>
                  <node TEXT="relative_speed大于5m/s" ID="d7cd93fb3314993656f1aedbf1801c0c" STYLE="fork">
                    <node TEXT="ca_time = relative_speed / 2m/s2" ID="cba018bcbb55d8229d35dd0411455338" STYLE="fork"/>
                    <node TEXT="ca_dist = relative_speed * ca_time / 2" ID="37f2665291adfc06e87146cb1af3362a" STYLE="fork"/>
                    <node TEXT="jerk_acc_move_dist = jerk_acc_move_dist + ca_dist" ID="77053550090c75ea22f7f4eb2e65f05e" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="其他，jerk_acc_move_dist为0" ID="257fcbb9395c44f6ad7a4b63b9467793" STYLE="fork"/>
              </node>
              <node TEXT="遍历obs，计算aware的obs" ID="e648e3b0ae5f9992adc6d740afc4c20f" STYLE="fork">
                <node TEXT="候选目标" ID="6a4bc115973e4ca49b39ea76148c7116" STYLE="fork">
                  <node TEXT="tracking time大于0.7s" ID="76012f8f8c5a8f0f08f4878529fbf606" STYLE="fork"/>
                  <node TEXT="obs_tail_to_ego_head在[0, 150]" ID="1f8687bbc202d6a2b521781b03c0e6eb" STYLE="fork"/>
                  <node TEXT="obs_l_to_ego_l小于5m" ID="8b883ed191289ae1a05489d01fc16952" STYLE="fork"/>
                  <node TEXT="occupy_lane_dist大于-0.7m" ID="5ea3387d0a09ae009f92c16e0d68b3f3" STYLE="fork"/>
                </node>
                <node TEXT="计算纵向安全距离" ID="31cd58a43c1ae8e4db0fecdfb3faa9ba" STYLE="fork">
                  <node TEXT="head_tail_time = min(ego_speed * 0.1s, 4m)" ID="b028068af729bc74fc7400c8b4726135" STYLE="fork"/>
                  <node TEXT="若obs快于自车" ID="4e0443bd17cb31fcbacf31c54f3b7429" STYLE="fork">
                    <node TEXT="在自车左侧，向右运动，则补偿距离=relative_speed * 2.5s" ID="8ef6b1ed4b0d5653348b1dfd648f7bbd" STYLE="fork"/>
                    <node TEXT="在自车右侧，向左运动，则补偿距离=relative_speed * 2.5s" ID="c8d5d08d6e1a0d611f61d9e0d845eb17" STYLE="fork"/>
                    <node TEXT="其他，补偿距离 = head_tail_time" ID="e3fa3f400551d094004a496449f8fad6" STYLE="fork"/>
                    <node TEXT="安全距离 = jerk_acc_move_dist + max(0, (head_tail_time - 补偿距离))" ID="14df0b3ec5625b7b682b359766d045e1" STYLE="fork"/>
                  </node>
                  <node TEXT="其他，安全距离=2*head_tail_time" ID="84a67a9807f40a0dbeef6b21db792258" STYLE="fork"/>
                </node>
                <node TEXT="obs_tail_to_ego_head大于纵向安全距离，则忽略" ID="4ebe444f33eddc3275fde1a059a915ec" STYLE="fork"/>
                <node TEXT="relative_lat_dist &gt; 0且obs_l_v &gt; -0.1m/s，或relative_lat_dist &lt; 0且obs_l_v &lt; 0.1m/s，则忽略" ID="01c2e173d570ce738f4f413f6e8e5320" STYLE="fork"/>
                <node TEXT="对truck目标，做多帧的occupy_lane_dist小于0.35m的debounce" ID="55ca428cd4303abefdac7915128d9cb6" STYLE="fork"/>
              </node>
              <node TEXT="遍历obs，计算cutin的obs" ID="40f7604cbadb65739ca410c00c7891c8" STYLE="fork">
                <node TEXT="候选目标" ID="ff6e954f78e758db7c5c1730de6349b8" STYLE="fork">
                  <node TEXT="仅针对car目标" ID="36e9312a518520d58e21b78bc2b860fa" STYLE="fork"/>
                  <node TEXT="tracking time大于0.7s" ID="627a688f2f8f1843e96173ad6d3205bc" STYLE="fork"/>
                  <node TEXT="obs_tail_to_ego_head在[0, 150]" ID="a08a124c37d3ea4e8965ddac172eb2c1" STYLE="fork"/>
                  <node TEXT="abs(relative_lat_dist)大于3.5m" ID="0ac0a1030b45598bf458706cf740d3a4" STYLE="fork"/>
                </node>
                <node TEXT="计算纵向安全距离" ID="859064200db50085ee00b0d1528ca250" STYLE="fork"/>
                <node TEXT="obs_tail_to_ego_head大于纵向安全距离，则忽略" ID="c35eda8a67cb23919f9a2c3f77389d03" STYLE="fork"/>
                <node TEXT="relative_lat_dist &gt; 0且obs_l_v &gt; -0.1m/s，或relative_lat_dist &lt; 0且obs_l_v &lt; 0.1m/s，则忽略" ID="265b0b0cceb00a8dcc52b955bfb0aff0" STYLE="fork"/>
                <node TEXT="根据历史状态确定cutin" ID="3b2dbf3ad050cca4b51696d88b989885" STYLE="fork">
                  <node TEXT="relative_lat_dist和obs_l_v" ID="336c9e9dfb88313425a4b2e3228e93f9" STYLE="fork"/>
                </node>
              </node>
            </node>
          </node>
        </node>
        <node TEXT="变道决策" ID="e747fd359720e18d2409bdcd2e8b233e" STYLE="fork">
          <node TEXT="根据交通拥堵信息（traffic_info）更新lane change策略" ID="fd1d854ed12508d196a39bd04922d6e4" STYLE="fork">
            <node TEXT="15s以上或700以外的traffic_info无效" ID="c07780cef645315f9cb62f92fd9b1cc8" STYLE="fork"/>
            <node TEXT="轻度、中度、重度的拥堵" ID="6d52c7633625f84f2618217a70372b70" STYLE="fork"/>
          </node>
          <node TEXT="更新到split点的距离" ID="f2d0864a76e1296607743d01ee4dd84e" STYLE="fork">
            <node TEXT="抑制junction之后的split（split_dist + 20m &gt; junction_dist）" ID="fd77b55cdf730168d0c2a6e46f3b2eef" STYLE="fork"/>
            <node TEXT="check lane keep的route和left/right的route的overlap" ID="ed77a08b4c67c0c62f13f66e3f376469" STYLE="fork"/>
          </node>
          <node TEXT="check左/右变道是否有效" ID="a2ad3ddd1153d6480ba60ea0c4d3ff9b" STYLE="fork">
            <node TEXT="是否被锥桶抑制变道，则debounce时间为10s" ID="28430e0cf0526a24b6558c896e3f8207" STYLE="fork"/>
            <node TEXT="遍历potential obs" ID="8917c50abcc4bbb4c75ed6c81a5fa85b" STYLE="fork">
              <node TEXT="找s在[-6, 6]，l在[0, -ego_l+0.6m]之间的目标在2个以上，则抑制变道，debounce时间为2s" ID="7524eed7810db7c5c662e25051c8604e" STYLE="fork"/>
            </node>
          </node>
          <node TEXT="获取最大的left/right的变道次数，route的优先级&lt;=lane keep route的优先级" ID="82cb271600e2602427f0e9c35d9f80d4" STYLE="fork"/>
          <node TEXT="更新变道功能安全" ID="cd0c9abf79859736a6ad16af15568703" STYLE="fork">
            <node TEXT="安全前向时间：4s，安全前向distance buff：0m" ID="fc192f5f4757accf100f7eeb4de16c88" STYLE="fork"/>
            <node TEXT="安全后向时间：4.5s，安全后向distance buff：2m" ID="0968bb2ac018098394f9f49d39f3bec7" STYLE="fork"/>
            <node TEXT="若可以向左变道（route有效，且左参考车道有效），则check左变道的功能安全" ID="ed663adac37ade6c57a692afff106fcd" STYLE="fork">
              <node TEXT="目标车道选左侧参考车道" ID="b517b4fc5f9c548d1b519b954f1fb70f" STYLE="fork"/>
              <node TEXT="若是lane change，则横向的buff为0.7m，否则为0m" ID="e3fc31ec16fcba79c293d468bbad01a6" STYLE="fork"/>
              <node TEXT="选择目标obs（前方150m，一个目标）" ID="e3824a48c4fb98e9fee5382371939d9e" STYLE="fork">
                <node TEXT="若为ool nudge，则选择front obs作为候选" ID="48c7800765a392f2ff76f463b0683beb" STYLE="fork"/>
                <node TEXT="否则若为左/右变道，选择left/right side back obs作为候选" ID="2f166706b892dc27d24ec667b8fe4600" STYLE="fork"/>
                <node TEXT="遍历候选目标" ID="c0cfd7e30ad795129d13e11187d0dd9e" STYLE="fork">
                  <node TEXT="根据obs的速度方向选择" ID="3f24417d774b8e9c738c57832bd822f1" STYLE="fork">
                    <node TEXT="逆向obs，在自车-2m之后，且和车道线的heading_diff大于120°，则忽略" ID="1f5af32538a678c10195ee8a7bbcc66b" STYLE="fork"/>
                  </node>
                  <node TEXT="若obs为truck，横向buff增加0.5m" ID="850a2326d427f6d874d64d493ce97a94" STYLE="fork"/>
                  <node TEXT="按照横向buff选择obs，obs的左右在中心线左右正负（1/2自车的宽度+0.7m）以内" ID="2d54fe689102fcbfadb6b43b53b97830" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="若前后的obs均有效，则比较自车到其的距离，找距离最小的作为不安全的agent" ID="d7d8c7106c3009957c49e5add3f3eb38" STYLE="fork"/>
              <node TEXT="若前/后是逆向obs，则修正vel和acc为0" ID="716e45f02227a1dc0b8bf61a876a3ca7" STYLE="fork">
                <node TEXT="和车道线的heading_diff大于正负135°" ID="524e3f8242e6be8dfc89dd2ecb6b6e14" STYLE="fork"/>
              </node>
              <node TEXT="check前/后向快车的功能安全" ID="f0e883f6f4bb515705d79c82b649522a" STYLE="fork">
                <node TEXT="根据相对速度check纵向安全距离的功能安全" ID="2ceb4732e78edca0b56f7b53cf34be4f" STYLE="fork">
                  <node TEXT="若相对速度大于15kph，则s_diff（obs_s - ego_s - obs_half_length - ego_front_edge）需要大于0" ID="b045a2aa93d4275ac3d030d42caec0f3" STYLE="fork"/>
                  <node TEXT="若相对速度大于8kph，则s_diff（obs_s - ego_s - obs_half_length - ego_front_edge）需要大于3m" ID="f91d67340b6df9a3feba5fd33fe79ea7" STYLE="fork"/>
                </node>
                <node TEXT="按照ca/cv模型计算自车/obs的未来2s的s" ID="c510e6bacced3096aa2fc6526d6935a0" STYLE="fork">
                  <node TEXT="若v + at &gt; 0，则按ca模型计算s" ID="5a3a822b43773f57351ea52f8c27d451" STYLE="fork"/>
                  <node TEXT="否则，若a等于0，则按cv模型计算s" ID="132df1b4f5406a3c86e838a2dc6fcdc0" STYLE="fork"/>
                  <node TEXT="其他，按照减速到0，计算s" ID="414b9c28a3306bebc89d691fe7ccc998" STYLE="fork"/>
                </node>
                <node TEXT="再次根据自车/obs的s, v, a，相对速度check纵向安全距离的功能安全" ID="55a80aa1c6806f3cd04a410facfa4221" STYLE="fork"/>
              </node>
              <node TEXT="前向有安全obs" ID="224e79c7604b80d8fa4ac0b626414164" STYLE="fork">
                <node TEXT="若ool nudge，计算前向安全距离" ID="96e1f8f1ca9032a9de8045982d71591f" STYLE="fork">
                  <node TEXT="低速（0kph）安全距离：1m" ID="d3a4670c2f37b7462ec2965773e5a629" STYLE="fork"/>
                  <node TEXT="高速（120kph）安全距离：15m" ID="93799aad5e298ee1bdc3da63cde78d06" STYLE="fork"/>
                  <node TEXT="根据当前车速线型插值" ID="c48e9a5254ba94d8ae33faea6df61de4" STYLE="fork"/>
                </node>
                <node TEXT="不为ool nudge，计算前向安全距离" ID="f65f12eab5c9e21913a9434127d59758" STYLE="fork">
                  <node TEXT="低速（65kph）安全距离：6m" ID="c9d5d2390a1f730b353a9a77f6c08de4" STYLE="fork"/>
                  <node TEXT="高速（120kph）安全距离：15m" ID="f0465d0646c44b85bb4cb163e0a40c79" STYLE="fork"/>
                  <node TEXT="根据当前车速线型插值" ID="bf99bc864b23c3db27dbf8cd8653d779" STYLE="fork"/>
                </node>
                <node TEXT="jerk为const，check前向安全距离" ID="626b07b96372315fd667fe28755c3c73" STYLE="fork">
                  <node TEXT="最小减速度0.7m/s2，最大减速度3m/s2" ID="452d25c8167fa0347a8f437f338adc5d" STYLE="fork"/>
                  <node TEXT="按jerk不变check前向安全距离" ID="dc516f765396a71d99595aca6f7d5e0f" STYLE="fork">
                    <node TEXT="若ego_v大于obs_v，则按jerk不变计算减速的st（distance, time）" ID="89a26556e01ecea41b617efa3608d994" STYLE="fork">
                      <node TEXT="若obs_v大于ego_v，则安全" ID="bbe90739d43c946f9e395b543ce42a2c" STYLE="fork"/>
                      <node TEXT="若当前自车的减速度已经小于最小减速度，则计算减速时间 = (obs_v - ego_v) / 最小减速度" ID="c7a223602e834f55b8b6b06692a1d985" STYLE="fork"/>
                      <node TEXT="否则，求解一元二次方程 0.5jerk * x^2 + ego_a * x + (-obs_v + ego_v) = 0，得到减速时间" ID="4c1ea3586027005470cea6ba77c5321f" STYLE="fork"/>
                      <node TEXT="若按照ca模型计算的减速度小于最小减速度，则按照分段计算（svat）" ID="55835e2f59b5bd7961863bd7bc184bfa" STYLE="fork">
                        <node TEXT="first_time = (最小减速度 - ego_a) / jerk" ID="6e40af0a3c7a9bbd6f1979bd43cb9f20" STYLE="fork"/>
                        <node TEXT="first_v = ego_v + ego_a * first_time + 0.5 * jerk * first_time^2" ID="b4d39d33afa020ce0d692cd98548c46e" STYLE="fork"/>
                        <node TEXT="second_time = min((obs_v - first_v) / 最小减速度, 减速时间-first_time)" ID="754f4c18417faee474af61f17adcba60" STYLE="fork"/>
                        <node TEXT="first_v = ego_v + ego_a * first_time + 0.5 * jerk * first_time^2" ID="3303819e63048627df00cb104eb3fa9b" STYLE="fork"/>
                      </node>
                      <node TEXT="若按照ca模型计算（svat）" ID="540e261ac73b33b678e6e1a1b510979a" STYLE="fork"/>
                      <node TEXT="计算obs未来的s" ID="5c820b6c2900ca05e04e918a15c330ed" STYLE="fork"/>
                      <node TEXT="安全距离增量 = ego未来的s - obs未来的s" ID="121464bffb8339b3dd8d477b6583b08a" STYLE="fork"/>
                    </node>
                    <node TEXT="若s_diff &lt; 安全距离，则不安全" ID="eca25f4641d9764a059791d88ff64263" STYLE="fork"/>
                    <node TEXT="若速度大于0.2且减速时间大于0.1s" ID="ae83cef6632bbd9b450b206b2540ace8" STYLE="fork">
                      <node TEXT="计算引入gauss噪声的obs减速度 = e^(-减速时间^2 / (2*2.33^2)) * obs_a" ID="4393145cbace909cb8179756f89adef3" STYLE="fork"/>
                      <node TEXT="递归按jerk不变check前向安全距离" ID="f489981bc120f1a67b005abda38b321d" STYLE="fork"/>
                    </node>
                  </node>
                </node>
                <node TEXT="按照ego_a为-0.6m/s2和veh_a计算前向安全距离" ID="0684373eb5cb4469da031ec74c067595" STYLE="fork">
                  <node TEXT="安全距离增量 = 0.5*v_diff^2 / 0.6m/s2" ID="ae72b9a21eb476ee1a7104373acc43f3" STYLE="fork"/>
                  <node TEXT="计算4s后的ego和obs的s_diff，若小于安全距离，则不安全" ID="ca5ae496ecc94f8a86ae9b12dde51efa" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="后向有安全obs" ID="380bd59e5527794db8ee0dce0e01995e" STYLE="fork">
                <node TEXT="若ool nudge，计算后向安全距离" ID="9bcbf95caeba5ade2e073518672e513f" STYLE="fork">
                  <node TEXT="低速（0kph）安全距离：1m" ID="d7610fd0ebba9c653c0621b8c4898934" STYLE="fork"/>
                  <node TEXT="高速（120kph）安全距离：13m" ID="97e81bb9dd1aece49554376d328661cf" STYLE="fork"/>
                  <node TEXT="根据当前车速线型插值" ID="706703f557b596061651ed4f32762f5b" STYLE="fork"/>
                </node>
                <node TEXT="不为ool nudge，计算后向安全距离" ID="4e2046cd5d47d025b8f2745bd0ad44ca" STYLE="fork">
                  <node TEXT="低速（50kph）安全距离：6m" ID="24e01234fab3fea386f583b03985ba6b" STYLE="fork"/>
                  <node TEXT="高速（120kph）安全距离：13m" ID="6f4f19392a6d3c832204519a0b962786" STYLE="fork"/>
                  <node TEXT="根据当前车速线型插值" ID="552a7e06bccdf9b2f6a7dd0fa356f512" STYLE="fork"/>
                </node>
                <node TEXT="按照cv模型计算后向安全距离" ID="2cc4899bf732bc5fdb7b6d37c825b679" STYLE="fork">
                  <node TEXT="根据后向安全时间及ego_v、obs_v计算安全距离" ID="3e574be7fe55415bb21f12e3663ba227" STYLE="fork"/>
                  <node TEXT="计算4s后的ego和obs的s_diff，若小于安全距离，则不安全" ID="06fbd7f1bee59c553b432805c13ce540" STYLE="fork"/>
                </node>
              </node>
            </node>
          </node>
          <node TEXT="若是变道确认，则生成变道请求" ID="42801d652c2d1384f9a505517a41a406" STYLE="fork"/>
          <node TEXT="是否允许触发变道" ID="9a3ca15597ed731ee6c78d98b293c4ab" STYLE="fork">
            <node TEXT="若是lane map，则禁止" ID="2c900e03091deae0c9d02eb7eed2657b" STYLE="fork"/>
            <node TEXT="服务区内，允许" ID="f56d23e744fa3693450ae1c47f71c5b9" STYLE="fork"/>
            <node TEXT="速度在[0, 130]外，则禁止" ID="c5e5edc4e9c53237cf16b7c31c5f936e" STYLE="fork"/>
            <node TEXT="距离终点200m以内，则禁止" ID="45e0589f8383cdcbafa18c39e6911073" STYLE="fork"/>
            <node TEXT="距离路口10m以内，或当前车道为左转/右转/向左uturn/向右uturn，则禁止" ID="dfeab1fb9495da796da345c8f28a978d" STYLE="fork"/>
          </node>
          <node TEXT="生成紧急变道避障请求" ID="9412f1e9050021e0437d38d292e3eaac" STYLE="fork">
            <node TEXT="左右边界为自车的左右加0.6m的buff" ID="df2fa269f675388f9861b1299bbd9301" STYLE="fork"/>
            <node TEXT="遍历本车道前方的obs" ID="8fb1f53c285213471349dcaedb49a92c" STYLE="fork">
              <node TEXT="仅考虑锥桶和unknown static类型的obs" ID="4afac1c3193cbd03aeda319723630ec3" STYLE="fork"/>
              <node TEXT="life time超过200ms" ID="0db6102e9e51371e678c1ab81bd33134" STYLE="fork"/>
              <node TEXT="计算long_diff = obs_s - ego_s，大于200m，忽略" ID="3e1f16c9b880511ca942b7cade7441dd" STYLE="fork"/>
              <node TEXT="若obs在左右边界内（obs_left_l, obs_right_l），则需要紧急避障" ID="1b5fe19e74639f2341dbc5aa27d4d5f2" STYLE="fork"/>
              <node TEXT="紧急避障场景的上升沿（紧急避障持续0.4s）" ID="5b823ea285e69ff483db0f69eff6a1c5" STYLE="fork"/>
            </node>
            <node TEXT="根据split点的类型（left/right），选择左/右变道，左变道优先" ID="71ef2b79a9797f6ce2c19b8fe37734da" STYLE="fork">
              <node TEXT="" ID="3524584374943980243f3294d662517e" STYLE="fork"/>
            </node>
          </node>
          <node TEXT="生成导航变道请求" ID="ccdde5e0388a26fd466657acb690b2f4" STYLE="fork">
            <node TEXT="若未触发紧急变道避障" ID="1c15986135a060316ad6966fd8cd3157" STYLE="fork"/>
            <node TEXT="OED的distance小于300m（operational event domain）" ID="76b72d486f1ce1bbf992b8d62aff37e1" STYLE="fork"/>
            <node TEXT="获取到本车道到split的距离（到导航的split点的距离-当前route的split点的距离）" ID="8e3a460412a7a1184d4b709945f3684f" STYLE="fork"/>
            <node TEXT="若本车道到split的距离大于0且小于100m，且当前为最右侧车道（to_ramp_lane_change为1），且split为下匝道，且到导航的split点的距离大于15m，则需要前方变道" ID="db7a372769ff5de78e947760510392ed" STYLE="fork"/>
            <node TEXT="根据split的类型（left/right）和route的优先级及其长度，计算向左/右变道距离，左变道优先" ID="d647dbd8b644b30fd5a9fd56a702b401" STYLE="fork">
              <node TEXT="汇出时的变道距离=1100m+(换至最左/右车道的变道次数-1)*500m" ID="daaab6ec4bd9ce6356665d286f72b536" STYLE="fork"/>
              <node TEXT="计算到旁车道的变道距离" ID="03b4002710b168a66b1053fdd2aebf12" STYLE="fork">
                <node TEXT="通过right route递归找到右车道的变道距离" ID="ee0ce7a053874204c24ca754659578e4" STYLE="fork"/>
                <node TEXT="通过boundary计算变道距离" ID="e7c83465a4c7fa0d337db016d574cc7f" STYLE="fork">
                  <node TEXT="往前DFS的最远距离=max(到导航的split点的距离-变道距离+500m, 0)" ID="65fa1a87ebf12bab080731fc5d12d0c7" STYLE="fork"/>
                  <node TEXT="DFS得到boundary info" ID="4129bd8af5dd6e222e7f9f147ae7bf4d" STYLE="fork">
                    <node TEXT="使用road map从规划的init point开始查，暂不使用navi map" ID="54d101a3bf6fe14262811adb8db9f228" STYLE="fork"/>
                    <node TEXT="根据boundary的crossable属性和left/right变道类型match" ID="b3e008776646b90c252873f95e9e0859" STYLE="fork">
                      <node TEXT="both：双向可变道" ID="9fabac4766815104da2c00efbcb6cf05" STYLE="fork"/>
                      <node TEXT="left：右到左可变道" ID="d89f95f9f206735b211d51172b7051bd" STYLE="fork"/>
                      <node TEXT="right：左到右可变道" ID="c7dcaecea000f8e09ce5510191dfcf3f" STYLE="fork"/>
                    </node>
                    <node TEXT="若boundary类型变化（从可跨越到不可跨越，或者从不可跨越到可跨越）" ID="94b5948035d471222ccc764658eb0b81" STYLE="fork"/>
                  </node>
                  <node TEXT="计算solid line的距离" ID="8ed9cb5414283b79ca311a6092ef8746" STYLE="fork"/>
                </node>
              </node>
            </node>
            <node TEXT="无更高优先级的变道，则进行优先级变道决策" ID="73ee36de6a5bb5609b2ed05f0df63e3c" STYLE="fork">
              <node TEXT="check左右变道是否有短split车道" ID="41beb363c8327e34d0929f539a897a1a" STYLE="fork">
                <node TEXT="选择left/right为target route" ID="de13be3d2199b41413cf6cf4ee8cfc17" STYLE="fork"/>
                <node TEXT="split车道长度=当前route上到split的距离-target route上到split点的距离" ID="3d99a8e96307d4b5d306fdf3774b64a0" STYLE="fork"/>
                <node TEXT="若target route上到split点的距离小于150m，且split车道长度大于0小于100m，则为短split车道" ID="67c52705225c55bcb5ad9c769a54b70a" STYLE="fork"/>
                <node TEXT="split点所属的lane的左右boundary为VIRTUAL_AUXILIARY_LINE，则忽略" ID="3ac50e95eba881bc46ce8fa2dcbdaf76" STYLE="fork"/>
              </node>
              <node TEXT="若左右变道有短split车道，trigger distance为小于15s车速" ID="51ef9c7743eeb4c028c7e4fc2b7dfd63" STYLE="fork"/>
            </node>
            <node TEXT="无更高优先级的变道，则进行merge变道决策" ID="04b02cf4182f206b297e71fd3f9aad6b" STYLE="fork">
              <node TEXT="获取ego lane map上的merge信息" ID="203906614127c093d9390b6cac0f8be0" STYLE="fork">
                <node TEXT="" ID="12ec935f53af86820c4c7bd6b8f1c4b6" STYLE="fork"/>
              </node>
              <node TEXT="是否inhibit" ID="5f2c1b66ab29e0022414244f3673a0fe" STYLE="fork">
                <node TEXT="lane在路口里" ID="985f419460466ffcbc171c14d30333f5" STYLE="fork"/>
                <node TEXT="当前车道为左转/右转/向左uturn/向右uturn" ID="8cb769812d1faa58861527d226fec9c7" STYLE="fork"/>
              </node>
              <node TEXT="城区场景且到merge点的距离大于100m，则忽略" ID="7ac510f730c8801e4804de68096fcfcd" STYLE="fork"/>
              <node TEXT="conflict点的阈值=max(3s车速, 10m)" ID="300bb2c56a6c18854475f094717f1372" STYLE="fork"/>
              <node TEXT="若conflict点-ego_s小于阈值，则为lane keep route merge（need_reject_task）" ID="0e229debf9351d0c946187d4b5c4f289" STYLE="fork"/>
              <node TEXT="根据merge点类型选择变道方向（left_forward/right_forward）" ID="8a212db1144e5cc6790f749aa7a32bd0" STYLE="fork"/>
            </node>
            <node TEXT="无更高优先级的变道，则进行优选车道变道决策" ID="229e06b03beaa75a1b2313d2ca8994e0" STYLE="fork">
              <node TEXT="30kph下，抑制优选车道变道" ID="9c2edfc4945e246743d118c540eae171" STYLE="fork"/>
              <node TEXT="距离split点小于3km，且split类型为匝道，抑制优选车道变道" ID="f8f402629b1c2c4a43445b6e714a634d" STYLE="fork"/>
              <node TEXT="距离odd边界500m以内，抑制优选车道变道" ID="d37ce7450c37763951089f74b7647747" STYLE="fork"/>
              <node TEXT="OED的distance小于1km（operational event domain），抑制优选车道变道" ID="6a37cc11dac0385df5f81f979ea7c9d1" STYLE="fork"/>
              <node TEXT="两车道（左右车道数+1），抑制优选车道变道" ID="b3e0a93de4685a3907bb65ae0a07fa21" STYLE="fork"/>
              <node TEXT="若右侧车道数为0" ID="84349ab9f55b049806213f495d3a95a4" STYLE="fork">
                <node TEXT="找到mid route的前车，并得到其车速（表显车速和实际车速转换）" ID="527977078560fb50941b80bb2857bf4f" STYLE="fork"/>
                <node TEXT="计算left route的车流车速" ID="bb045a20a7d8a886bd79b3aa503af8ef" STYLE="fork">
                  <node TEXT="找到left front的obs" ID="fbf7587ded1f356c8ef33cb43384aa2d" STYLE="fork"/>
                  <node TEXT="得到前车和前前车" ID="102a3b83906e8633c8dbc1fc9e7a962e" STYLE="fork"/>
                  <node TEXT="车流车速=min(min(前车车速, 前前车车速), user_set_speed)" ID="ab5cb42f9f37c3ee58c0934495598dd8" STYLE="fork"/>
                </node>
                <node TEXT="若距离merge点小于400m，且自车的表显车速大于45kph，且left route的车流车速大于mid route的前车，则避免merge" ID="a6ef8f067dea95b4b82769760edb47bd" STYLE="fork"/>
                <node TEXT="距离merge点700m以上，抑制优选车道变道" ID="984a25230ce12beed74e8e1d4355c984" STYLE="fork"/>
                <node TEXT="若避免merge，则生成变道请求，否则做和超车变道之间的互斥" ID="797f18aeda2294f81dc2da2ed876a127" STYLE="fork"/>
              </node>
            </node>
          </node>
          <node TEXT="生成超车变道请求" ID="a63ad4888840e50fcf335a769f2a3ded" STYLE="fork">
            <node TEXT="距离odd边界500m以内，抑制超车变道" ID="a3d1950622f972a15cdf38b398089a5b" STYLE="fork"/>
            <node TEXT="在匝道上，抑制超车变道" ID="0d84e72fae90fa1eb9b3b5f6158993d5" STYLE="fork"/>
            <node TEXT="对于城区，且距离merge距离超过120m，超车变道的最小车速为10kph，其他为20kph" ID="83819183728b8cc919a25587ad79c6de" STYLE="fork"/>
            <node TEXT="变道过程中，抑制超车变道" ID="aefc7b9aa8a966df87e624504d937e07" STYLE="fork"/>
            <node TEXT="计算超车目标" ID="4bdf44d6fa1f0148d808480710ca082f" STYLE="fork">
              <node TEXT="对风险obs计算超车变道" ID="69955e30ba463e623d8a8f4275cf9def" STYLE="fork">
                <node TEXT="从aware obs中选取纵向距离最近的obs" ID="44001fa95b0e2d8a9d313685feb91210" STYLE="fork"/>
                <node TEXT="若obs的横向相对l小于0，则向左变道，否则向右变道" ID="ea0c397b62cdf2dfadd8c39890642331" STYLE="fork"/>
                <node TEXT="根据左右route的有效性和功能安全，过滤" ID="846a86ff13d04bed8b313969e12926ba" STYLE="fork"/>
                <node TEXT="风险速度thresh = ego_v - obs_rel_v + 5" ID="190eacb0ddb8df922d22117c54a44a53" STYLE="fork"/>
                <node TEXT="根据变道方向，计算目标车道的车流车速" ID="735b40702991bd946fc4a1dedce48595" STYLE="fork"/>
                <node TEXT="若目标车道的车流车速大于风险速度thresh，则触发超车变道" ID="d4e4f52f99dbecfea583d8bb71b40937" STYLE="fork"/>
              </node>
              <node TEXT="对前方慢车计算超车变道" ID="8972a5f10975e694f7fdfdbb29513e93" STYLE="fork">
                <node TEXT="超车变道上升沿" ID="81680f32a8a46ebef8a4137e59064385" STYLE="fork">
                  <node TEXT="计算long_diff = obs_s - ego_s，大于180m，则不触发超车变道" ID="06b391cd60ce461ac5d0a07a5559cf28" STYLE="fork"/>
                  <node TEXT="speed_diff = max(user_set_speed - 前车表显车速, 0.01m/s)" ID="3e0b73396c886a1dfb5e2cd95b3d877a" STYLE="fork"/>
                  <node TEXT="ttc = long_diff / speed_diff，ttc大于24s，则不触发超车变道" ID="d48dbc65aeb83c4357c2d6fe69c3d61f" STYLE="fork"/>
                  <node TEXT="超车速度差阈值" ID="3cd6167eab3370f9df95b5054f20b4a4" STYLE="fork">
                    <node TEXT="高速（大于90kph）5kph，雨天12kph" ID="90d3472dba4fb3ded7b6ed09cdacad94" STYLE="fork"/>
                    <node TEXT="低速（小于90kph）5kph，雨天9kph" ID="313f9bfd83746db6e0efac21ce0caa44" STYLE="fork"/>
                  </node>
                  <node TEXT="若速度差大于阈值（自车表显高速/低速），则触发超车变道" ID="3aaba56fe97d44e91e450ff09af9aa77" STYLE="fork"/>
                  <node TEXT="否则，若速度差占比超过user_set_speed的10%（雨天15%），则触发超车变道" ID="a0227d5d8971c85f26e440ca81765f5a" STYLE="fork"/>
                </node>
                <node TEXT="超车变道下降沿" ID="309a96564980425b7780bd240d988bb7" STYLE="fork">
                  <node TEXT="计算long_diff = obs_s - ego_s，大于180m，则停止保持超车变道" ID="b8c14fc119866ca075824c56ced00e33" STYLE="fork"/>
                  <node TEXT="ttc大于48s，则停止保持超车变道" ID="8721e1323ed9f40bce88d700b21cee57" STYLE="fork"/>
                </node>
                <node TEXT="超车计数更新" ID="15f0c0dd26e40f3b2b0c208f64ae6f0b" STYLE="fork">
                  <node TEXT="第*帧计数器值=Round（（set speed-自车车速）/5）＋ 更新阈值（car：2，truck：5）" ID="264c2b83b05578a7e4a21cba1e9f1b05" STYLE="fork"/>
                  <node TEXT="针对车道数和前车truck类型，进行right的超车计数阈值的更新" ID="82b7d720e6eff51c2201a4b0e719346c" STYLE="fork"/>
                </node>
                <node TEXT="计算左右侧的车流车速" ID="59812fee32fedf45d15926625978b602" STYLE="fork"/>
                <node TEXT="是否左/右侧超车变道" ID="2216a27cf6cdf12034f947208d712ade" STYLE="fork">
                  <node TEXT="3公里以内下匝道，抑制超车变道" ID="f9c556c39f4200911a9ade081eb808ce" STYLE="fork"/>
                  <node TEXT="1公里以内split，根据优先级抑制超车变道" ID="0ebda4eaac6c67880ec1dd5b19870e8c" STYLE="fork"/>
                  <node TEXT="700m以内有merge点，且非urban场景，抑制超车变道" ID="0fb380ba1601c0f8646d579bfd758cd1" STYLE="fork"/>
                  <node TEXT="速度差阈值" ID="25f8c829681f12ce30767e479bd14294" STYLE="fork">
                    <node TEXT="前车高速（&gt;=80kph）7kph" ID="3b4ae41780c0d206683d8b2c72e34fd7" STYLE="fork"/>
                    <node TEXT="前车低速（&lt;=60kph）14kph" ID="9571ccb43e1146e620a69a7aaa0309c1" STYLE="fork"/>
                    <node TEXT="其他插值计算" ID="cdd9ecc9a0a59045162eb1ea1ea37d7d" STYLE="fork"/>
                  </node>
                  <node TEXT="针对车道总数小于3个，或左车道数目不为0时，额外增加5kph的buff" ID="a5bc7c87876213f05d9c74866bbc3a8c" STYLE="fork"/>
                  <node TEXT="若车流车速-前车车速大于速度差阈值，则触发超车变道" ID="58116d695f77c86b9e3e5ddc3f03040d" STYLE="fork"/>
                  <node TEXT="超车变道的等待时间为0.5s" ID="3eca9c6b3e3bac023094ec09bd44dec1" STYLE="fork"/>
                </node>
              </node>
            </node>
          </node>
          <node TEXT="若被超车辆变道方向和自车相同，做超车变道取消" ID="e08dbb96caa53b8caf55c049d932803d" STYLE="fork">
            <node TEXT="根据被超车辆历史状态（3帧），计算平均横向速度（求frenet下的横向速度）" ID="a53e7dcbeb03a715e028b0bd1d3fb9fb" STYLE="fork"/>
            <node TEXT="计算自车和前车的long_diff" ID="faed2dd41b91895bf66e5db548b3f2c2" STYLE="fork"/>
            <node TEXT="超车变道取消的条件" ID="5f12178aa0009f12a3932888ae72a8a4" STYLE="fork">
              <node TEXT="自车处于lc_prepare" ID="b73b55b6ad7b79ec92cee76b0936d5c0" STYLE="fork">
                <node TEXT="向左变道，且前车的横向速度大于0.4m/s，且前车的横向距离大于1.1m" ID="2272969cedfcab50402ef0ec2469b729" STYLE="fork"/>
                <node TEXT="向右变道，且前车的横向速度小于-0.4m/s，且前车的横向距离小于-1.1m" ID="462caeffa5dbbba853c0d96b2d91e1dd" STYLE="fork"/>
              </node>
              <node TEXT="自车处于lc中" ID="80aa9571931e916bb75c2ddb86a2f681" STYLE="fork">
                <node TEXT="和前车的long_diff大于140m" ID="aae91197fe3854e5cfe8178dd8bf6c0f" STYLE="fork">
                  <node TEXT="向左变道，且自车的横向距离小于0.4m，且前车的横向速度大于0.4m/s，且前车的横向距离大于1.1m，且尚未过变道折回点" ID="4d4a3c5d71bc6fd956253b260f004c1d" STYLE="fork"/>
                  <node TEXT="向右变道，且前车的横向速度小于-0.4m/s，且前车的横向距离小于-1.1m，且尚未过变道折回点" ID="03ac6efd96245ef2dac294eb6359d5aa" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="其他" ID="290b905d2aa81ae4eb63471b08f50ce8" STYLE="fork">
                <node TEXT="若为向左变道" ID="8fcacfc05afdb8138d51b6c512cbaee2" STYLE="fork">
                  <node TEXT="左前车的速度-被超车辆的速度小于速度差阈值，且左前车的long_diff小于180m，则累计左前慢车的帧数" ID="f5f33e1b27a8f838a0c98405db345359" STYLE="fork">
                    <node TEXT="速度差阈值" ID="e809ca175a46f02afd734c61e9eef306" STYLE="fork">
                      <node TEXT="long_diff大于140m，为-3" ID="80a2a1a2f7fa5b5a972261f4fa5e3967" STYLE="fork"/>
                      <node TEXT="long_diff小于30m，为0" ID="0879162d283f46753d7faecb70bea3f5" STYLE="fork"/>
                      <node TEXT="其他插值" ID="7c59e01f7e53da6d3c434c51fd2b91fa" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="在帧数&gt;=2帧，且未过变道折回点，则取消变道" ID="900c89309f247b36fb0e54a3fbc28c53" STYLE="fork"/>
                </node>
                <node TEXT="若为向右变道" ID="b55e83634b74cd232b4ff19a161edc08" STYLE="fork"/>
              </node>
            </node>
          </node>
          <node TEXT="根据dynamic map，做实线变道抑制" ID="9a9467cd24c8e6aa3a482d31f255519f" STYLE="fork">
            <node TEXT="对于split/merge/下匝道/匝道汇入/split时的车道保持/优先级，不做抑制" ID="c62bb10185ef576d53b5daf8bb56ee5d" STYLE="fork"/>
            <node TEXT="其他，则根据感知车道线的crossable类型（physically not/legally not），做实线变道抑制" ID="1ad3fbaed95ff1acc44790991e867339" STYLE="fork"/>
          </node>
          <node TEXT="根据da inhibit，做变道抑制" ID="8f49ac9429ddca0ae859ea416352acff" STYLE="fork">
            <node TEXT="仅对用户拨杆变道、超车变道、优先级变道和split，根据da inhibit做变道抑制" ID="c8105f3229aaa9aecb13769dec4965fc" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="OOLNudge决策" ID="12dd42a8983abc886f9b90f61d879932" STYLE="fork">
          <node TEXT="选择OOL Nudge的obs" ID="ec1e12ee0393cfd7220fa6f623b61b0b" STYLE="fork">
            <node TEXT="获取居中车道前方的obs" ID="3798923a6ca704c61b2fa05b25b6a4b3" STYLE="fork">
              <node TEXT="两侧的目标个数为4，中间的nudge目标个数为2" ID="a8d51e544d5a090fe3c9071d0a745e14" STYLE="fork"/>
              <node TEXT="忽略life time小于700ms的obs" ID="a259f1edbf62ca1757d05497b76bf2f8" STYLE="fork"/>
              <node TEXT="根据obs的角点计算在居中车道上的min_l, max_l, min_s, max_s" ID="c26ce6597d11620f3f693f466f171be5" STYLE="fork"/>
              <node TEXT="计算左右boundary上的max/min l" ID="7132d6587a178007958f901ac7f67c50" STYLE="fork">
                <node TEXT="左侧" ID="ee8819bf7dc0f33643109b7452e5ea66" STYLE="fork">
                  <node TEXT="max_l = 3.3m + 0.5自车宽度 + nudge_safety_offset(0.5m)" ID="a8150c015d7b602ae10b971dd8c1408a" STYLE="fork"/>
                  <node TEXT="min_l = 3.3m - 0.5自车宽度 - nudge_safety_offset(0.5m)" ID="2570dd9cfb8dee29ac01a695fac0ebd3" STYLE="fork"/>
                </node>
                <node TEXT="右侧" ID="82e831a0f575c56a81b36b87ce9cc032" STYLE="fork">
                  <node TEXT="max_l = -3.3m + 0.5自车宽度 + nudge_safety_offset(0.5m)" ID="48a3333cf8b81be83e7405e50a295b4b" STYLE="fork"/>
                  <node TEXT="min_l = -3.3m - 0.5自车宽度 - nudge_safety_offset(0.5m)" ID="eba6f594384f00d697cb2346fb7216f0" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="若obs_min_l小于右侧boundary的min l，或大于左侧boundary的max l，则忽略" ID="276a56db040fc4b62ab367ba2480824c" STYLE="fork"/>
              <node TEXT="若obs_min_l大于左侧boundary的min l，则作为left obs" ID="d104790116117b1bbe68f02c1b3d904c" STYLE="fork"/>
              <node TEXT="若obs_min_l小于右侧boundary的min l，则作为right obs" ID="768c2e6fddb979ca233330a79fdab3f8" STYLE="fork"/>
              <node TEXT="obs在中心线左侧（obs_min_l &gt; 0）" ID="a6554aa360330d49747381061e612aef" STYLE="fork">
                <node TEXT="偏移量=obs_min_l - nudge_width(0.5m) - 自车宽度 - 车道线宽度（0.3m）" ID="03b340d7a1877c8ea834951755f06e8e" STYLE="fork"/>
                <node TEXT="偏移量&lt;右侧boundary，则因为横向空间触发ool nudge" ID="4f77d2014c376e36a3e3fd30c82b1b5a" STYLE="fork"/>
                <node TEXT="obs_min_l &lt;= 1m，则因为中心线触发ool nudge" ID="89bd02ed1aec0f7cd65450919451859a" STYLE="fork"/>
              </node>
              <node TEXT="其他" ID="da830964f74ee0ec55f093a11f8af12e" STYLE="fork">
                <node TEXT="偏移量=obs_max_l + nudge_width(0.5m) + 自车宽度 + 车道线宽度（0.3m）" ID="33a1cfb9958f00c6a94afb2ec618b611" STYLE="fork"/>
                <node TEXT="偏移量&gt;左侧boundary，则因为横向空间触发ool nudge" ID="91371f237bde0c9c44581fe8d7b5b36c" STYLE="fork"/>
                <node TEXT="obs_max_l &gt;= -1m，则因为中心线触发ool nudge" ID="711fb7bc575ba1713a0a09576d665632" STYLE="fork"/>
              </node>
              <node TEXT="仅在横向空间触发ool nudge和中心线触发ool nudge同时有效，才能作为ool nudge的obs" ID="459582052ba822291553e8a4ac159a3e" STYLE="fork"/>
              <node TEXT="obs在车道boundary内，且是ool nudge obs，则作为center obs" ID="670a07433dc74a66692c73a85fcab872" STYLE="fork"/>
            </node>
          </node>
          <node TEXT="计算OOL Nudge的可通行性（ttc）" ID="c28a374d606278c6e8c0ed8df6bbeb44" STYLE="fork">
            <node TEXT="分别按照left, center, right obs取对应的obs" ID="e5814b68f1d1d31db08c58b3d7344796" STYLE="fork">
              <node TEXT="计算center的obs是否在居中车道" ID="a8441ed1fa23c8a6f7a39e076586945d" STYLE="fork">
                <node TEXT="速度为负或者大于0.2m/s，则不在居中车道" ID="5f2af9e310aabe838b337ae8cd1d9845" STYLE="fork"/>
                <node TEXT="obs_min_s大于80m，则不在居中车道" ID="8f4f400c3f6f25d4c559c3718d4a940a" STYLE="fork"/>
                <node TEXT="urban【道路类型2-6】，obs_min_s小于8m，则不在居中车道" ID="6cea778e3eeec518f51bd6fa8e782cd4" STYLE="fork"/>
                <node TEXT="psp，obs_min_s小于5m，则不在居中车道" ID="a0b4274c6e3fb4f6e8a069fcde5e2018" STYLE="fork"/>
                <node TEXT="对于非行人且速度大于0.5m/s，计算obs和车道中心线的heading_diff，若大于120°，则不在居中车道" ID="b0bd28e25121dd3ee6ac224b4d375400" STYLE="fork"/>
              </node>
              <node TEXT="根据obs_min_s, obs_v, ego_v, ego_max_v（local route上的平均最大限速），计算ttc" ID="b15007f79cfc747b875063209e909d62" STYLE="fork">
                <node TEXT="max_v = max(ego_v, ego_max_v)" ID="3c89b664e49ed4baab72f2a8ecdd4bab" STYLE="fork"/>
                <node TEXT="max_a = 0.6m/s2" ID="8a5bd8d46e9270abd665c4cbae5f8236" STYLE="fork"/>
                <node TEXT="若max_v &lt; 0，则100s作为ttc" ID="d1c791a0445d7f579bd8baa185ebff69" STYLE="fork"/>
                <node TEXT="若obs_min_s &gt; max_v * 100s，则100s作为ttc" ID="132894f4c643837dd6094bf8181e210d" STYLE="fork"/>
                <node TEXT="若obs_v小于max_v" ID="972c0533b5161349f94e9564f3f7d201" STYLE="fork">
                  <node TEXT="求解一元二次方程 0.5max_a * x^2 + (ego_v - obs_v) * x - obs_min_s = 0，得到ttc" ID="32b11ba6cc72178152a4a44b2c4e0121" STYLE="fork"/>
                  <node TEXT="若ego_v + ttc*max_a &gt;= max_v，则ttc = (max_v - ego_v)^2 / (2*max_a*(max_v - obs_v)) + obs_min_s / (max_v - obs_v)" ID="09895e1d71ab6cbf322113b56f8cf0a7" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="最小的ttc作为lane的ttc" ID="c83c5e6269c61c0a6f49948772297df8" STYLE="fork"/>
            </node>
          </node>
          <node TEXT="计算OOL Nudge的可行性" ID="77099b09f427ee00c3dfd0aed0f92ca8" STYLE="fork">
            <node TEXT="更新lane的有效性" ID="383f0baca2210a9daaac772bec4bdff1" STYLE="fork">
              <node TEXT="取center lane的ttc及center obs，若ttc小于100s，且obs_v小于0.3m/s" ID="0113cb98d6c858591dffd91d8b27c647" STYLE="fork">
                <node TEXT="obs的life time大于6s，再保持4s以上，借实线为true" ID="00272df6b2d66ecb1d627cfa8618e5b5" STYLE="fork"/>
              </node>
              <node TEXT="距离路口的距离小于60m，借实线为false" ID="aabbef85f3f33bfafe65681adbe9a163" STYLE="fork"/>
              <node TEXT="nudge time = max(center lane ttc, 4.5s) + 4.5s" ID="d881f81f27a512a1c6163e1afba64de9" STYLE="fork"/>
              <node TEXT="forward_s = max(nudge time * ego_v, 20m)" ID="85ee5cd189fdfd9c3fd14b4a78a8d664" STYLE="fork"/>
              <node TEXT="check是否可跨越" ID="9fc1dac2d8b93ab131a769ebf1574d20" STYLE="fork">
                <node TEXT="获取当前参考点的左右边界的属性及其距离路口的距离，得到是否可跨越" ID="a3aae4dc5ab95fe48a57c710732843d3" STYLE="fork">
                  <node TEXT="路口(-20, 60)，不可跨越" ID="459324a00de0356f5e13256fb2ad9863" STYLE="fork"/>
                  <node TEXT="左边界：BOTH或RIGHT_TO_LEFT，且不为PHYSICALLY NOT" ID="da0993793b2010eca8d1764677973721" STYLE="fork"/>
                  <node TEXT="右边界：BOTH或LEFT_TO_RIGHT，且不为PHYSICALLY NOT" ID="363b1384389db9513ddf0542988dcfd7" STYLE="fork"/>
                </node>
                <node TEXT="按照从当前参考点到forward_s，5m采样，计算左右可跨越" ID="ab854769b1791d4ac4388df38cf60ca4" STYLE="fork"/>
                <node TEXT="遇到不可跨越，则终止" ID="a257959502782a772ebdf94f19856c76" STYLE="fork"/>
              </node>
              <node TEXT="check左右车道有效性" ID="d7be867207cbabe016140062ebc8b271" STYLE="fork">
                <node TEXT="获取左右车道，若车道为收费车道或应急车道或逆向车道，则无效" ID="3cc68381c3b15c656d8d6d890b042de5" STYLE="fork"/>
              </node>
              <node TEXT="check左右车道是否被锥桶抑制" ID="f15acbd281d282da0f87f1cdab40ecfb" STYLE="fork">
                <node TEXT="若被锥桶抑制变道或抑制变道未冷却3s以上，则无效" ID="d7cfd9a855aa5581cfc5170fa10b5579" STYLE="fork"/>
                <node TEXT="其他，有效" ID="23855548a22d8c73844702f3409c905a" STYLE="fork"/>
              </node>
              <node TEXT="check左右车道的曲率有效性" ID="eb0332bb92d223a77cdfce242f76deeb" STYLE="fork">
                <node TEXT="max_steering_angle = 500°" ID="e6ceefdcfa65d7b9c4cbc903db198d29" STYLE="fork"/>
                <node TEXT="steering_ratio = 16.5" ID="5adcb828c27c4fa4f6c09db5bbdc9777" STYLE="fork"/>
                <node TEXT="steer_angle_nudge_thresh = max_steering_angle / steering_ratio * 0.7" ID="4bd05836ce3ce68ec9cc23081fe39264" STYLE="fork"/>
                <node TEXT="curvature_thresh = tan(steer_angle_nudge_thresh) / wheel_base（2.85m）" ID="19f1956f7722c45c59dea713d6e04deb" STYLE="fork"/>
                <node TEXT="radius = 1 / curvature_thresh" ID="20b2e001440a7b4195c21408d3c4c1a3" STYLE="fork"/>
                <node TEXT="以自车位置为原点，以curvature_thresh和-curvature_thresh为半径分别向左/右画圆" ID="40f5ffb74fd4cb186080e0465a55b4ae" STYLE="fork"/>
                <node TEXT="对center obs[0]的obs，计算其角点到自车位置的距离，若距离大于radius+0.5自车车宽，则有效" ID="47b8088ab66fbe628d9391336a2f9560" STYLE="fork"/>
              </node>
              <node TEXT="check车道数的有效性" ID="8a14dfe91b0d0b4823ee08382f5e1620" STYLE="fork">
                <node TEXT="非urban【道路类型2-6】，则有效" ID="d18d62899e296d2b08c63d48a6bfff25" STYLE="fork"/>
                <node TEXT="获取到最右车道的lc次数，若为0，则有效" ID="5eaf1ec8b7f8f67391c2573084dd211d" STYLE="fork"/>
              </node>
              <node TEXT="左/右车道的有效性需要同时满足：左/右可跨越、左/右车道有效性、左/右车道不被锥桶抑制、左/右车道的曲率有效、车道数有效" ID="db7054f2aa2f6e94f76005423d16bcd3" STYLE="fork"/>
              <node TEXT="center始终有效" ID="ff07c2887d90207a9409ce4195638a53" STYLE="fork"/>
            </node>
            <node TEXT="更新lane的功能安全" ID="963aa8dee7506cb1a78e1e2e5406b7f4" STYLE="fork">
              <node TEXT="计算nudge的横向offset" ID="034e7b203a9d31fe15463156612d3279" STYLE="fork">
                <node TEXT="max = center obs[0]的max_l" ID="f17b3ac3c9f400a901963c16fa37c122" STYLE="fork"/>
                <node TEXT="min = center obs[0]的min_l" ID="88918a42c89e764bd10ae169c6dff49b" STYLE="fork"/>
              </node>
              <node TEXT="更新左/右车道的nudge lateral offset" ID="7acb4fd3689f0e4696a6c0bd683b71cf" STYLE="fork">
                <node TEXT="init_nudge_offset = 2.5m（若左/右车道有效，则为3m）" ID="a9977557adc700f032ccf3cffac25e74" STYLE="fork"/>
                <node TEXT="左车道" ID="3c80ca5c0fedf504bce76a728b95e16e" STYLE="fork">
                  <node TEXT="nudge offset = max(init_nudge_offset, obs_max_l + 0.5自车车宽 + 1m)" ID="c42bbb58f47a640fa5de2f1178b6f097" STYLE="fork"/>
                </node>
                <node TEXT="右车道" ID="b75467063beb50f06beb1d07149ba746" STYLE="fork">
                  <node TEXT="nudge offset = min(-init_nudge_offset, obs_min_l - 0.5自车车宽 - 1m)" ID="bae792a11fbfd34fe270ba6d9e31be78" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="check向左/右lc的功能安全" ID="8bc359e4355e46f53779fd91ce78e3c4" STYLE="fork">
                <node TEXT="安全前向时间：4s，安全前向distance buff：0m" ID="56295f59b6c07e3315feabc3e464935d" STYLE="fork"/>
                <node TEXT="安全后向时间：4.5s，安全后向distance buff：3m" ID="74f00ee2f720d61dc4d4fafc2f40b319" STYLE="fork"/>
                <node TEXT="根据向左/右lc的功能安全进行多帧计数[0, 20]" ID="196643bd305668d727045a680aa933bf" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="更新返回原lane能力" ID="1812737cfd964f1e2e39c66a9be322da" STYLE="fork">
              <node TEXT="nudge time = max(center lane ttc, 4.5s) + 4.5s" ID="a533588d28fc03a12d53f0e88de9c585" STYLE="fork"/>
              <node TEXT="forward_s = max(nudge time * ego_v, 20m)" ID="a9df93089fcf1b501048cd71884937cc" STYLE="fork"/>
              <node TEXT="若有路口，且到路口的距离 &lt; forward_s + 40m，则左右车道都不能返回" ID="405d97dbe6978366857d083546f758ae" STYLE="fork"/>
              <node TEXT="若left/right route有效，且剩余长度 &gt; forward_s + 40m，则左/右车道能够返回" ID="6e9c9dc23685f74a4caad96f047a02e1" STYLE="fork"/>
            </node>
          </node>
          <node TEXT="更新ool nudge的task" ID="5d0e1863cd76d1990bd709df1d5eb270" STYLE="fork">
            <node TEXT="若当前为ool nudge结束（cancel, none, finish），则reset nudge task" ID="ff5b81456baeab8fa9a37968feb0002c" STYLE="fork"/>
            <node TEXT="nudge prepare的cnt阈值为10帧" ID="80143380c4d6d25b4c034ca530064606" STYLE="fork"/>
            <node TEXT="ttc_delta_thresh为15（对于道路类型6，为6）" ID="785dd293f61f7ec8f9c8f234bed5ed99" STYLE="fork"/>
            <node TEXT="更新左/右车道的prepare计数" ID="6e9f0245a8bad6ff8bb7352df8487c50" STYLE="fork">
              <node TEXT="若左/右车道有效，且功能安全计数为20，且左/右车道的ttc - center的ttc &gt; ttc_delta_thresh，且该车道能返回，则prepare+1，否则prepare-1" ID="db5a9e69ca27214a3d92ef336f935922" STYLE="fork"/>
            </node>
            <node TEXT="是否触发nudge" ID="0fc403756bf362e01a41a8f582967c54" STYLE="fork">
              <node TEXT="若center的ttc &gt; 30s，则不触发" ID="64c7f33101579746fa3691d223a713d6" STYLE="fork"/>
            </node>
            <node TEXT="向左还是向右nudge" ID="9478c7a01ebf84567ee89f801504aec1" STYLE="fork">
              <node TEXT="根据优先级，选择优先级小的" ID="19afe962c4f98839de254b92ae0d1ad1" STYLE="fork"/>
              <node TEXT="优先级相同，则根据ttc，选择ttc大的" ID="dfd603b5b9a35fe8cfe4de7cbc4175c5" STYLE="fork"/>
            </node>
          </node>
          <node TEXT="更新ool nudge的blocked状态" ID="fe1f9906b6fd2236e8cd680aa3c870c2" STYLE="fork"/>
        </node>
        <node TEXT="BP" ID="c1423db93b0d96d19b42521a1ade6402" STYLE="fork">
          <node TEXT="准备" ID="9ec4baf1f91c3dede1d7ee60e4b026d1" STYLE="fork">
            <node TEXT="计算限速（曲率限速）" ID="f495da087f0db7c70c3ba6869b5c1c8b" STYLE="fork">
              <node TEXT="s_forward = min(max(20, ego_v * 5s), lane_length)" ID="06454d2f03f35269241e6469e7211113" STYLE="fork"/>
              <node TEXT="按0.2m分辨率到s_forward" ID="f188cb21c138cd4662a16a4ea9a540a6" STYLE="fork">
                <node TEXT="获取中心线的曲率c" ID="a784facace15ad2ef97b3fbcf106b101" STYLE="fork"/>
                <node TEXT="max_v = min(max_v, weight(1.4) * sqrt(lat_acc(0.8m/s2) / max(c, 0.00001)))" ID="0574164ee708c0bf6d4661918988dfd9" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="前向仿真器初始化（LC+OOL Nudge）" ID="028a2a81d809f7166fee236987f7b020" STYLE="fork">
              <node TEXT="获取打转向灯到lc的时间" ID="944bf1cbc3c3572a5f93e6c1efa6cf8c" STYLE="fork">
                <node TEXT="max time= 0.5s（雨天模式+2s）" ID="25319a8a18126c19fedf1e0b5ebc41d2" STYLE="fork"/>
                <node TEXT="min time= 0.5s（雨天模式+2s）" ID="79bfed2f960bf40cd9999cff1a04bb13" STYLE="fork"/>
                <node TEXT="根据s（500m, 1000m）和max/min time进行插值" ID="1760a65d5bc025083a1b1d267c9879ab" STYLE="fork"/>
                <node TEXT="对于紧急变道避障，时间统一为0.5s" ID="edaff90ecb4a431175f9d8a13a4dbe96" STYLE="fork"/>
              </node>
              <node TEXT="变道空间（slot）选择" ID="22578ff1cf0c6d7e22771a92158214bb" STYLE="fork">
                <node TEXT="前后s_range：(-80, 80)" ID="a89150035b15a21f828d7dd99ba7dbe6" STYLE="fork"/>
                <node TEXT="选择左右车道的目标obs（s_range，前2个，后2个）作为candidates" ID="9f86c3db6436c7c8796daa3590affbfd" STYLE="fork"/>
                <node TEXT="增加虚拟obs" ID="fe65b26f2493f7a04fdf77b19d9ca88e" STYLE="fork">
                  <node TEXT="若前方obs数目小于2，且前前obs_s + 0.5车长 + 20m小于80m，则在80处增加虚拟obs（速度为180）" ID="410029ff68b0c13687ddd1f453ca4937" STYLE="fork"/>
                  <node TEXT="若后方obs数目小于2，且后后obs_s - 0.5车长 - 20m大于-80m，则在-80处增加虚拟obs（速度为0）" ID="27b498e2647827f45bd03d26d5619d14" STYLE="fork"/>
                </node>
                <node TEXT="依次按照front, back把obs链接起来" ID="258ffd5710291faecd7bba9e8d9575b6" STYLE="fork"/>
                <node TEXT="对齐slot的front_s" ID="5d53f0686a022676569f281d7725ae49" STYLE="fork">
                  <node TEXT="若back_obs_s &gt; 0，则front_s为back_obs_s" ID="7e55730f166d3d3812b8d2100777853c" STYLE="fork"/>
                  <node TEXT="若front_obs_s &lt; 0，则front_s为front_obs_s" ID="2411b48b164f8509e7a5331cd16780ed" STYLE="fork"/>
                  <node TEXT="其他，front_s为front_obs_s和back_obs_s取小" ID="b1c97235bda52654fc5318b161fdce61" STYLE="fork"/>
                </node>
                <node TEXT="获取自车的前车信息" ID="7ae0cbdece4755b56a2d635d04d07323" STYLE="fork"/>
              </node>
              <node TEXT="选择最优变道空间（slot）" ID="94a44543becd74bda8d4c04848ce13c1" STYLE="fork">
                <node TEXT="slot_acc = 1m/s2" ID="32683c49d4a4cce1c5f0918507272fe1" STYLE="fork"/>
                <node TEXT="slot_dec = 1m/s2" ID="4828297b1787f40c08ba76c53bc62f30" STYLE="fork"/>
                <node TEXT="计算slot的v" ID="3c126c7a712bea30d72c00926fbcdcf1" STYLE="fork">
                  <node TEXT="若front_obs_v &gt; back_obs_v，则slot_v = min(front_obs_v, max(ego_v, back_obs_v))" ID="11152bdf6c5c3bab8bb6883c8de6eae9" STYLE="fork"/>
                  <node TEXT="否则，根据front_s的对齐，决定是front_obs_v，还是back_obs_v" ID="09ffc82cd45cd5fd292215643162e939" STYLE="fork"/>
                </node>
                <node TEXT="计算slot的time" ID="9e1351385867cce2fa46f2b992c1d849" STYLE="fork">
                  <node TEXT="从加速到减速（acc_to_dec）" ID="5a9552834f8ef3b1fd2b9154eafc9b6e" STYLE="fork">
                    <node TEXT="求解加速时间" ID="1c26c71198937ca43a438aa157033dbc" STYLE="fork">
                      <node TEXT="acc = 1.0m/s2, dec = 1.0m/s2" ID="3fd732a7b581f2c4b4c2250677256bb9" STYLE="fork"/>
                      <node TEXT="a = (0.5*acc + 0.5*acc^2/dec)" ID="33adb87ab9d9cc0cdd9e9a29084d2117" STYLE="fork"/>
                      <node TEXT="b = (ego_v - slot_v) + (ego_v - slot_v)*acc / dec" ID="07eec9e047596e693cf4a2d27ec61eb8" STYLE="fork"/>
                      <node TEXT="c = 0.5*(ego_v^2 - slot_v^2)/dec - slot_v*(ego_v - slot_v)/dec - slot_front_s" ID="f28140651cd13108766e7bc28779ab46" STYLE="fork"/>
                      <node TEXT="求解一元二次方程得到acc_t" ID="a7a17f30f7a0fac67089a9257d0f8edb" STYLE="fork"/>
                    </node>
                    <node TEXT="求解减速时间" ID="8d38b8b0a5455d1036575c08591751e3" STYLE="fork">
                      <node TEXT="dec_t = ((ego_v + acc * acc_t) - slot_v) / dec" ID="f20dd709561f8ff47e3ea0cda650a7a0" STYLE="fork"/>
                      <node TEXT="acc_t + dec_t小于7s" ID="308dba4a0f71840fe6a7966b594acf73" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="从减速到加速（dec_to_acc）" ID="8033307feb789f70584b98c9c09ab766" STYLE="fork">
                    <node TEXT="求解减速时间" ID="6f58db31974d1cb084e2b767deed66fe" STYLE="fork">
                      <node TEXT="acc = 1.0m/s2, dec = 1.0m/s2" ID="939b4d9a59c4265443380b292bea0648" STYLE="fork"/>
                      <node TEXT="a = (-0.5*dec - 0.5*dec^2/acc)" ID="c7237bf32a2980ab833f13b7a0b8fb5f" STYLE="fork"/>
                      <node TEXT="b = (ego_v - slot_v) + (ego_v - slot_v)*dec / acc" ID="3294a33776161d1d1b1724268310f09a" STYLE="fork"/>
                      <node TEXT="c = 0.5*(slot_v^2 - ego_v^2)/acc - slot_v*(ego_v - slot_v)/acc - slot_front_s" ID="87809d912526605b2e4c2cb054b2413a" STYLE="fork"/>
                      <node TEXT="求解一元二次方程得到dec_t" ID="4d1355e7b621b70dcb412e26a1047379" STYLE="fork"/>
                    </node>
                    <node TEXT="求解加速时间" ID="702514787e45c28e7fbba46625d60bd9" STYLE="fork">
                      <node TEXT="acc_t = (slot_v - (ego_v - dec * dec_t)) / acc" ID="78d21a3b783a3075985404abd94e278d" STYLE="fork"/>
                      <node TEXT="acc_t + dec_t小于7s" ID="d67d6aeca9b0f2794cfeb333a1722b29" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="若acc_to_dec和dec_to_acc都无效，则slot无效" ID="8d6272062f22a2c3e155b3906b5c6259" STYLE="fork"/>
                  <node TEXT="若acc_to_dec和dec_to_acc都有效，则选总时间最小" ID="bedde9519baef179c2e7a94035086141" STYLE="fork"/>
                </node>
                <node TEXT="计算slot的剩余空间" ID="83982f1e9d6cea88427d5d21f8cf8dd8" STYLE="fork">
                  <node TEXT="time = slot_time + half_lc_time(3.5s)" ID="cf6007dbef80465c2254f1568ba214d6" STYLE="fork"/>
                  <node TEXT="剩余空间=front_obs_s - back_obs_s - (back_obs_v - front_obs_v)* time" ID="23e95d22b761b22acfbc7a69e3ff5ebe" STYLE="fork"/>
                  <node TEXT="若剩余空间小于20m，则slot无效" ID="67ca2701d278be5db8cbd37f14a177b6" STYLE="fork"/>
                </node>
                <node TEXT="根据前车check slot的可用性" ID="004be05cbdb4fdd9a07a8cff9ac0944f" STYLE="fork">
                  <node TEXT="ego_future_s = slot_front_s + slot_v * slot_time + ego_s" ID="39592a04f524de33c354d5bf7bbe8080" STYLE="fork"/>
                  <node TEXT="leading_future_s = leading_s + leading_v * slot_time" ID="da353689d18053e7d397930d67d53612" STYLE="fork"/>
                  <node TEXT="space的阈值=buffer(5m) + (leading_v - ego_v)*headway_time(1s)" ID="401032b3a68a8b88b0b23ee6e0db8fa6" STYLE="fork"/>
                  <node TEXT="若leading_future_s - ego_future_s &lt; space的阈值，则slot无效" ID="e885824f3bdfb23e769525544c53c3e1" STYLE="fork"/>
                </node>
                <node TEXT="对变道触发类型校验有效性" ID="1c511404ae864756a03ee650c5c60636" STYLE="fork">
                  <node TEXT="若slot_front_s &lt; 0，且为优先车道变道或超车变道，则slot无效" ID="57d88e7bfbfe646e21f3cbd16881c4df" STYLE="fork"/>
                </node>
                <node TEXT="计算slot的cost" ID="a754a4a66f9808a7e71310ed293a4c75" STYLE="fork">
                  <node TEXT="cost = slot_time^2 * ratio(1.0) + slot_acc * slot_acc_t / slot_time * acc_ratio(5) + slot_dec * dec_ratio(10)^2" ID="5de8b125cf644b05dd5709b6b42c6e23" STYLE="fork"/>
                </node>
                <node TEXT="cost最小的slot为最优slot" ID="c9c0a33011849a94c2189ee89e79aea7" STYLE="fork"/>
              </node>
              <node TEXT="check LC的有效性" ID="069684cc2d92be097d6797930bfb9445" STYLE="fork">
                <node TEXT="若最优slot的front_s &lt; 0或back_s &gt; 0，则LC无效" ID="a28589843a567b1b5ab73fa710c79135" STYLE="fork"/>
                <node TEXT="若为左/右变道，则check左/右变道的功能安全，获取前后的安全距离" ID="340d4a1cee4d75051d3cd2a074902c82" STYLE="fork">
                  <node TEXT="安全前向时间：4s（不为超车变道+0.5s），安全前向distance buffer：0m（不为超车变道+2m）" ID="e10aac81b8fc8ae7ec4f8e9e797759c8" STYLE="fork"/>
                  <node TEXT="安全后向时间：4s，安全后向distance buffer：2m" ID="13cf480ad268b5373af9420af31391c8" STYLE="fork"/>
                </node>
                <node TEXT="更新转向灯的状态" ID="d27d41df95222b2b00d8627343a849c2" STYLE="fork"/>
                <node TEXT="若为左/右转向灯点亮（超过触发时间），再次check左/右变道的功能安全" ID="00ce2eb402bff8723137ce4e79f144f2" STYLE="fork">
                  <node TEXT="安全前向时间：4s，安全前向distance buffer：0m" ID="0092bb3de766217d2a794ae48e4593aa" STYLE="fork"/>
                  <node TEXT="安全后向时间：4s，安全后向distance buffer：0m" ID="e7f574dcafe35243992f41a3bb59c5b5" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="过滤LC的obs" ID="892b9fadf69484d954fa8a96b186d2cc" STYLE="fork">
                <node TEXT="选择目标obs（前方150m，10个目标）" ID="799c62fd9956fd9aeb01623906913af3" STYLE="fork">
                  <node TEXT="若为左/右变道，选择left/right side front obs作为候选" ID="f30b6abc31c79272f482985edd903472" STYLE="fork"/>
                  <node TEXT="遍历候选目标" ID="73485bc48a6726352c2253821f346f49" STYLE="fork">
                    <node TEXT="若靠近目标车道，则忽略" ID="ceb82f535d0c1adeda844f84f9ef5613" STYLE="fork">
                      <node TEXT="obs_min_l &lt; 0.5自车车宽，或obs_max_l &gt; -0.5自车车宽" ID="6956bd80b1ca0887b417ab7b3df279bf" STYLE="fork"/>
                    </node>
                    <node TEXT="根据候选点（obs的5s的intention path（第24个点））及其heading在local map里找最近lane（3m，90°），并加入其前驱和后继，作为consider_lanes" ID="d1bb96727ae1e134431155fc6e251434" STYLE="fork"/>
                    <node TEXT="在目标车道上找到候选点的投影点（s相同），及其最近（3m，90°）的lane作为target_lane" ID="6e1cb62d4d81fe959ed1899cfa072b82" STYLE="fork"/>
                    <node TEXT="若target_lane不在consider_lanes中，则过滤" ID="bfbcd77489abeed586c09e2cf8f05bd2" STYLE="fork"/>
                    <node TEXT="若为左/右变道，target_lane的左/右车道在consider_lanes中，则过滤" ID="dbe2fb7cb218d8cfe2efdbc2d8862714" STYLE="fork"/>
                  </node>
                </node>
              </node>
              <node TEXT="check OOL Nudge（左/右）的有效性" ID="0ea2bd08ae96956195f2feffa71c7e08" STYLE="fork">
                <node TEXT="若当前处于nudge过程中，不重复check" ID="fbb470da2e1fe04b8408d1bfead03ae7" STYLE="fork"/>
                <node TEXT="若开始nudge" ID="774f611a6f3c2a21e452413e511153b7" STYLE="fork">
                  <node TEXT="横向thresh=abs(nudge目标的max_l【左变道】或min_l【右变道】) + 0.5自车宽度" ID="9ef08dc01610b82df9371c062db77655" STYLE="fork"/>
                  <node TEXT="若当前ego_l &gt; 横向thresh，则nudge有效" ID="3e97831c5066519d8b31e7d7092c1513" STYLE="fork"/>
                </node>
                <node TEXT="check向左/右nudge的功能安全" ID="14887c3355ee58b6da6540af6282abaf" STYLE="fork">
                  <node TEXT="安全前向时间：4s，安全前向distance buffer：0m" ID="121e0582989f5bbacf3d48e6ab9edd26" STYLE="fork"/>
                  <node TEXT="安全后向时间：4.5s，安全后向distance buffer：2m" ID="feca82c085cb3a5b14f0ba17ab9550d9" STYLE="fork"/>
                </node>
                <node TEXT="根据功能安全选择nudge方向" ID="22130af1ec452bf6b089a170e8cf6042" STYLE="fork">
                  <node TEXT="若左/右均满足功能安全，则left优先" ID="b91e43e1aaaabf1757f8f0daa90ed275" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="check当前车道上的可通行性" ID="9c8deb4f649909afaa59d9a7579e9730" STYLE="fork">
                <node TEXT="遍历attention的关键目标" ID="fae612031947cc4d475d633673ae3c6c" STYLE="fork">
                  <node TEXT="仅考虑静止目标（v &lt; 0.5m/s）" ID="b2d760996d2362f10e6a272036f07e41" STYLE="fork"/>
                  <node TEXT="过滤在车道boundary之外的目标" ID="a469887caf9b3db7f156ca1e057c121d" STYLE="fork"/>
                  <node TEXT="计算其sl包络" ID="3225ea38dd139ff7b4c622a23f36e87e" STYLE="fork"/>
                </node>
                <node TEXT="roi范围 = max(max(30m, 4s*ego_v), max(7s*ego_v, max_obs_end_s))" ID="843780f9b17ce56c6c1871d3ddfb2614" STYLE="fork"/>
                <node TEXT="resolution = max(0.5, roi范围/100)" ID="ae75eafd7384eeb90022ba3d8f226e3f" STYLE="fork"/>
                <node TEXT="根据roi范围、resolution及车道boundary和筛选出的关键目标，确定左右边界，及不可通行点" ID="6b8b2bb06afbb2ee486b777bafd6341b" STYLE="fork"/>
                <node TEXT="若存在不可通行点，则作为in lane nudge场景" ID="68bbe3fcd10fbe5a9b93bb95518ef17d" STYLE="fork"/>
              </node>
            </node>
          </node>
          <node TEXT="运行" ID="4a71547b633030485dd315d402c9ab52" STYLE="fork">
            <node TEXT="前向仿真器运行（LC+OOL Nudge）" ID="f271d6a7f106218ff0d358e56ff8b200" STYLE="fork">
              <node TEXT="上一帧的intention目标作为fs agents，更新自车信息" ID="c19fe111a0f2f0e821a03fc50ef1573c" STYLE="fork"/>
              <node TEXT="单车道决策（车道内nudge enable）" ID="e174e5575c9997b8539d639466fe6764" STYLE="fork"/>
              <node TEXT="根据变道方向决定current lane和target lane" ID="6a99b39c12152294985c2bf9fe7c372f" STYLE="fork"/>
              <node TEXT="虚拟障碍物决策" ID="d10e4fbba368999590bfaa2a01f3b2b2" STYLE="fork">
                <node TEXT="针对前车，虚拟障碍物的proposal为YIELD" ID="bd890654d43ecde447cac56905bdd3ee" STYLE="fork"/>
                <node TEXT="其他，虚拟障碍物的proposal为NOT YIELD" ID="990c22cc6158c79c9b8638a6c3b5699a" STYLE="fork"/>
              </node>
              <node TEXT="vru决策" ID="b313b832d1ceac8f8b6c47bd13a95aaf" STYLE="fork">
                <node TEXT="在fs agents中过滤行人（3）和bike（4）的目标" ID="bfbf7a80549b5449b9a29938587d687a" STYLE="fork"/>
                <node TEXT="若单车道的决策结果为yield，则过滤" ID="932c557a2778b5a708b8d1f822383d61" STYLE="fork"/>
                <node TEXT="遍历vru目标" ID="7634d5970a64fa821573fc85f703ff1a" STYLE="fork">
                  <node TEXT="计算vru目标的intention path（5s，分辨率为0.2s）和自车轨迹的cross point" ID="7dec816e007a60f87f74784e52119509" STYLE="fork"/>
                  <node TEXT="有cross point的作为候选目标" ID="4f2188d1633859588d9e482e5fbe9ce7" STYLE="fork"/>
                </node>
                <node TEXT="vru的特征提取" ID="92849f8fd9afef4febe1df60302c8413" STYLE="fork">
                  <node TEXT="" ID="32df7234afcdebcfd54db2a27fd22357" STYLE="fork"/>
                </node>
                <node TEXT="vru的规则模型" ID="19c799835674faf030c1db4998cf552a" STYLE="fork">
                  <node TEXT="遍历vru目标" ID="4c27faa5534234389226db7833442bcd" STYLE="fork">
                    <node TEXT="计算ego和vru到cross point的enter time和exit time（考虑车的长宽）" ID="7f0a87d99e06ef63e750fcfb563b400a" STYLE="fork"/>
                    <node TEXT="若ego和vru的enter time都大于10s，则vru的策略为NOT YIELD" ID="f14eb0ed54ea902b7dd0297a270e15a4" STYLE="fork"/>
                    <node TEXT="若ego_enter_time - vru_exit_time &gt; 4.5s，则vru的策略为NOT YIELD" ID="385162627cf5eaef22a67374021f5dad" STYLE="fork"/>
                    <node TEXT="若vru_enter_time - ego_exit_time &gt; 0.2s，则vru的策略为NOT YIELD" ID="e2ca732eff516cb3e2fe7ab8d66e8512" STYLE="fork"/>
                    <node TEXT="其他，则vru的策略为NOT YIELD" ID="4f8b45125c9456d78f87d61b6541349b" STYLE="fork"/>
                  </node>
                </node>
              </node>
              <node TEXT="merge决策" ID="dfb5f85348a6cdc58bcea8d28d068483" STYLE="fork">
                <node TEXT="从自车的lane map获取merge lanes" ID="5332410b7f84f6ac355e5cb56278d03d" STYLE="fork"/>
                <node TEXT="遍历merge lanes" ID="cdfa40897759963e8037cccf6e708e0e" STYLE="fork">
                  <node TEXT="根据merge lane获取merge的obs" ID="4fc372d15e65df1090945a5233c6b4e7" STYLE="fork"/>
                  <node TEXT="遍历merge的obs，过滤以下" ID="48d7953b64efdc9bf5da4019c5ecc23b" STYLE="fork">
                    <node TEXT="obs为unknown static" ID="e1b64e6aa3af5558b88b8e65074bdd41" STYLE="fork"/>
                    <node TEXT="obs为unknown dynamic，且速度小于0.7m/s" ID="002f2f6a60f0023ac93830f9229714de" STYLE="fork"/>
                    <node TEXT="obs为unknown" ID="1aa3cc1815585874c34a0956c4e19371" STYLE="fork"/>
                    <node TEXT="obs速度小于0.7m/s，且obs到merge点距离小于conflict点到merge点的距离" ID="01570a1491e2bce5db4c2352fc7b7397" STYLE="fork"/>
                    <node TEXT="若自车有路权，obs速度小于0.7m/s" ID="37531cebd7653c42f98353e4866b95d5" STYLE="fork"/>
                    <node TEXT="obs距离merge点大于200m" ID="2448af32fda47e6eb76e0e04ad5fdb57" STYLE="fork"/>
                  </node>
                  <node TEXT="生成slot信息" ID="dcd5bc012d66000816df448ddd610a11" STYLE="fork"/>
                  <node TEXT="从merge lane往前找50m，找其关联的obs，找距离merge点最近的，当前lane找不到，则找后继" ID="03d245678cba2982220cd5c25608b9f7" STYLE="fork"/>
                </node>
                <node TEXT="merge特征提取" ID="aa12687c9537815b6cc3cebea73e1360" STYLE="fork">
                  <node TEXT="遍历merge lane对应的merge raw features" ID="4e5fbfa2f97df1da3e88d2b47e115f18" STYLE="fork">
                    <node TEXT="自车特征" ID="420f3be705deb22f93e5da42ab26f276" STYLE="fork">
                      <node TEXT="" ID="04629725284b6e87810d5a064577b56b" STYLE="fork"/>
                      <node TEXT="计算merge_vec和conflict_vec间的角度，判断是否过conflict点" ID="e57c87ef0cb889791bc702b741d11e9a" STYLE="fork">
                        <node TEXT="cos_theta = dot_prod(merge_vec, conflict_vec) / (merge_vec.length() * conflict_vec.length())" ID="fffe80c0008f30b038b16334a3e057a7" STYLE="fork"/>
                        <node TEXT="若cos_theta &lt;=0，则过conflict点" ID="a155c625df9a551a5f1b305879c317c8" STYLE="fork"/>
                      </node>
                    </node>
                    <node TEXT="obs的特征" ID="ad8d82f953f21b8154b9d711af3cea6b" STYLE="fork">
                      <node TEXT="s为当前位置到merge点的s" ID="9f4a2dc701ec7728d40269e21946d5fe" STYLE="fork"/>
                    </node>
                    <node TEXT="feature map" ID="cd71f5ab5e6eae2e2ba52b8916bf20df" STYLE="fork">
                      <node TEXT="" ID="9c44263430f377aca004a628a0d056d8" STYLE="fork"/>
                    </node>
                  </node>
                </node>
                <node TEXT="遍历merge的slot" ID="6e620fbe3b1deea9a6e2aacb3e502e89" STYLE="fork">
                  <node TEXT="若自车没有路权，则基于学习的模型" ID="39c8ab42695ab2d42253f45163d949a3" STYLE="fork">
                    <node TEXT="按每个slot进行推理，获得其概率，进行softmax" ID="ca1bf9d96ec9a4e805fea6c878d8cf64" STYLE="fork"/>
                  </node>
                  <node TEXT="否则，基于规则的模型" ID="f2cb282c6dd95b1c46c0aea8cb379051" STYLE="fork">
                    <node TEXT="thresh = max(120m, ego_v * 7s)" ID="de22d845fa064683f9862ac5ca79100f" STYLE="fork"/>
                    <node TEXT="若自车到conflict点的距离 &gt; thresh，则延迟merge决策" ID="e967481bafefb28e9869a7914660848e" STYLE="fork"/>
                    <node TEXT="计算自车到conflict点的ttc" ID="2db4147a8bc4c21222a568a705257870" STYLE="fork">
                      <node TEXT="ego_acc = 1.5m/s2" ID="595d9ac6cf6d008f72197b46e04e8a1a" STYLE="fork"/>
                      <node TEXT="risk_distance = max(ego_to_merge - conflict_to_merge, 0)" ID="826a0408dd00d836a813830c506f955f" STYLE="fork"/>
                      <node TEXT="target_speed = sqrt(ego_v^2 + 2*ego_acc*risk_distance)" ID="1695ed3c4f2d6041b183f4c51290870e" STYLE="fork"/>
                      <node TEXT="若target_speed大于限速" ID="409918701ab83718fe8702f2e23fe4ae" STYLE="fork">
                        <node TEXT="ego_v大于限速" ID="b996d081e5d8314876b4b99cd25b9c30" STYLE="fork">
                          <node TEXT="ttc = risk_distance / ego_v" ID="435f1a21389aad5123171703944db75a" STYLE="fork"/>
                        </node>
                        <node TEXT="否则，ttc = (限速-ego_v) / ego_acc + (risk_distance - (限速^2 - ego_v^2))/(2*ego_acc)" ID="0eab429dec10952174bb168f854e6bc8" STYLE="fork"/>
                      </node>
                      <node TEXT="否则，ttc = risk_distance / (0.5*(ego_v + target_speed))" ID="9ba7b8eda9cb1602629d79ac3eb9d3ef" STYLE="fork"/>
                    </node>
                    <node TEXT="遍历所有的slot" ID="021d68d445bee57cbe60a7a6217fb448" STYLE="fork">
                      <node TEXT="check slot的可用性" ID="54f954fa563189a9582b23c30af16c00" STYLE="fork">
                        <node TEXT="使用krauss model给slot打分" ID="0fca42fea83fe41ac2713a3b11863b6d" STYLE="fork">
                          <node TEXT="对slot的前车和自车建模" ID="63e5df3c191372ca9e733980897edbdd" STYLE="fork">
                            <node TEXT="g = ego_to_merge - front_to_merge - 自车长度" ID="226c2d172860e4d3cbcc57632b02d040" STYLE="fork"/>
                          </node>
                          <node TEXT="对自车和slot的后车建模" ID="ebd80a8c65b7df0d7830c6b13478273f" STYLE="fork">
                            <node TEXT="g = back_to_merge - ego_to_merge - 自车长度" ID="11f0ed22d3daae033d246599556cc3d7" STYLE="fork"/>
                          </node>
                          <node TEXT="krauss model" ID="ef9fc788b779f080d37a2ca73e49d3f0" STYLE="fork">
                            <node TEXT="b = 5m/s2" ID="3275170e59f2e606f1493f7c1bdab4d0" STYLE="fork"/>
                            <node TEXT="τ = 1.5s" ID="f8718b46945b27b345963c192c2bb7b8" STYLE="fork"/>
                            <node TEXT="https://zhuanlan.zhihu.com/p/364208270" ID="e3a140377aa9c6751c2c6b55c62a10a5" STYLE="fork"/>
                          </node>
                          <node TEXT="计算加权分数" ID="4d117be3b74d47ff489d54229ef426fe" STYLE="fork">
                            <node TEXT="若自车有路权，若后车是truck，增加后车的权重" ID="fb177c3b73720e49ccd900427d023759" STYLE="fork">
                              <node TEXT="grade = 前车的速度差*主路权重1.5 + 后车的速度差" ID="5b40d098b26cffcae42b76d386aad36e" STYLE="fork"/>
                            </node>
                            <node TEXT="否则，若后车是truck，增加后车的权重" ID="6a61574665b5b289ea649d8a6995077e" STYLE="fork">
                              <node TEXT="grade = 前车的速度差 + 后车的速度差*主路权重1.5" ID="8ea00bee3f1624ad2e92c6d09666464c" STYLE="fork"/>
                            </node>
                            <node TEXT="仅有前车或后车时，忽略对应项" ID="35f95fe3e53e546a6d3c533654dda64e" STYLE="fork"/>
                          </node>
                        </node>
                        <node TEXT="使用IDM给slot打分" ID="5222a477ef36c2408c06c0db2b84a523" STYLE="fork">
                          <node TEXT="IDM模型" ID="6aaa1ea0fc134ea4c4f35fe923e72e12" STYLE="fork">
                            <node TEXT="https://zhuanlan.zhihu.com/p/440798064" ID="8f2c0b4d77e65e48b7b3c2586062065b" STYLE="fork"/>
                            <node TEXT="" ID="e68b43c8389f68bf3dfa23e9eeb3265e" STYLE="fork"/>
                            <node TEXT="α = 0.6" ID="5fb762be83a618d5271fc051184e68ab" STYLE="fork"/>
                            <node TEXT="vmax为限速" ID="6faf79009d92333af23b105d7d5b88dd" STYLE="fork"/>
                            <node TEXT="s* = 静止时的安全距离2m + back_v * 1s + back_v * (back_v - front_v) / (2*加速度1.5m/s2)" ID="4062adbac36dcdb535cffd85b0cc270c" STYLE="fork"/>
                            <node TEXT="△x = max(v_s - ego_s - 自车长度, 10m)" ID="d2c9bcc229bab0fbb3b72a76c5031666" STYLE="fork"/>
                          </node>
                          <node TEXT="计算ttc的权重" ID="f348f1886e1f4e6d87c87ba9b90f2fb6" STYLE="fork">
                            <node TEXT="obs_buffer" ID="00b04a76ff60d6c30acb1f421eec8c38" STYLE="fork">
                              <node TEXT="重卡（长度大于12m）：0.8" ID="023c90f5be88434adfd6449056bea553" STYLE="fork"/>
                              <node TEXT="中卡（长度（5.5m, 12m））：0.5" ID="87e77721dfa0f0f715f304875132e354" STYLE="fork"/>
                              <node TEXT="轻卡（长度小于5.5m）：0.2" ID="a71aeb61595d5cbcb2ad6a3988ef6353" STYLE="fork"/>
                            </node>
                            <node TEXT="若自车有路权，且自车距离merge点更近" ID="b7a21c44b1a69f3c588171b10adbf29b" STYLE="fork">
                              <node TEXT="若为truck，且idm_acc小于0，ego_buffer = 1.0" ID="d214ab9a60bc699b0c8767e4f73eff1a" STYLE="fork"/>
                              <node TEXT="否则，ego_buffer = 0.5" ID="9da0a6d646fa8a08d647098f5801a38c" STYLE="fork"/>
                            </node>
                            <node TEXT="若自车无路权，且自车距离merge点更远，ego_buffer = 1.5" ID="298780cb10d92998d803f4b4709c2635" STYLE="fork"/>
                            <node TEXT="其他" ID="cc9167020fdd4c004a273fd6721dab39" STYLE="fork">
                              <node TEXT="若idm_acc &gt; -3m/s2，且自车有路权，则ego_buffer = 0.5" ID="b589eb89ee9f573b7f214c45ae281166" STYLE="fork"/>
                              <node TEXT="若idm_acc &lt; -1.5m/s2，且自车无路权，则ego_buffer = 1.5" ID="699cc604a24ce12d30754ccb852bbbbd" STYLE="fork"/>
                            </node>
                          </node>
                          <node TEXT="计算前/后车到conflict点的ttc" ID="97ca1426b5e8506fc40050d37dab5b5e" STYLE="fork"/>
                          <node TEXT="比较自车ttc和前车ttc" ID="648e9b00a151bf0b831f4acab230859e" STYLE="fork">
                            <node TEXT="都接近0，则比较到merge点的距离，决定是否前车有效" ID="d77783dbbbaf84049511e83098430c3b" STYLE="fork"/>
                            <node TEXT="自车ttc小于0.2s，若前车ttc 小于 自车ttc*ego_buffer，则前车有效" ID="f740169628b304d04009919190e8bea6" STYLE="fork"/>
                            <node TEXT="否则，若前车ttc 小于 自车ttc*ego_buffer+obs_buffer，则前车有效" ID="66f948be43b5d44985b1a119f20ff1c3" STYLE="fork"/>
                          </node>
                          <node TEXT="比较自车ttc和后车ttc" ID="6960c30dc39d73bc56b564c6c405ecb2" STYLE="fork">
                            <node TEXT="都接近0，则比较到merge点的距离，大于自车则后车有效" ID="6e693c7ac9dd19dfa317214b7e4a8403" STYLE="fork"/>
                            <node TEXT="自车ttc小于0.2s，若后车ttc 大于 自车ttc*ego_buffer，则后车有效" ID="a84a5e38cd8739e5ec2cfe68fafa9b88" STYLE="fork"/>
                            <node TEXT="否则，若后车ttc 大于 自车ttc*ego_buffer+obs_buffer，则后车有效" ID="c3082a5363db9b4572cb7efa37a530ab" STYLE="fork"/>
                          </node>
                          <node TEXT="前后车同时有效，则slot的概率为0.5，否则为0" ID="4ea57783f76fe681956279199218b64c" STYLE="fork"/>
                        </node>
                      </node>
                      <node TEXT="idm的有效，则选择ttc最大的slot为最优slot（概率为1）" ID="b5817d7d202139e47fc4295a4c6b9033" STYLE="fork"/>
                      <node TEXT="idm无效，则选择krauss model的grade最大的作为最优slot" ID="a7a9ef406ffd509174c8654c52a95182" STYLE="fork"/>
                    </node>
                  </node>
                </node>
              </node>
              <node TEXT="crossing决策" ID="28d7b9ee52f37ddb1db5cdd1be807647" STYLE="fork">
                <node TEXT="仅针对urban和psp场景，high way不支持" ID="c814c2e6eb165e29085c48fe4c7683e2" STYLE="fork"/>
                <node TEXT="crossing的原始特征提取" ID="b13a825a97ec92848739131f16f5cb73" STYLE="fork">
                  <node TEXT="获取所有的crossing的obs" ID="c470c1f144ab5297a9499b1742cef1d0" STYLE="fork"/>
                  <node TEXT="遍历所有的fs agents" ID="aed4491a05910bb8a536e62179e91441" STYLE="fork">
                    <node TEXT="计算crossing信息" ID="e2e9a4cdfa89135cf34e1e757caf10ec" STYLE="fork">
                      <node TEXT="根据自车的轨迹线和obs未来6s的intention path，计算其cross point" ID="a4cf56a42c72d5c4ab9d14175b1bf1a4" STYLE="fork"/>
                      <node TEXT="对交点排序，按s从小到大" ID="8f6bb03dec944fe37fd55955fb91ba2d" STYLE="fork"/>
                      <node TEXT="计算自车位置到cross point的angle，若和自车的heading_diff超过90°，则忽略" ID="c4bb3d0ecd06a7e410f974adba0822cf" STYLE="fork"/>
                      <node TEXT="计算自车和obs的enter点和exit点" ID="19a7c2d94d002a6ae2571939e0a52697" STYLE="fork">
                        <node TEXT="车道宽度 = max(5.5m, max(obs_width, ego_width))" ID="92c8ca6b962f39c25d01bd79f1b6226c" STYLE="fork"/>
                        <node TEXT="enter点为cross point.x - 0.5车道宽度，加上自车heading旋转" ID="d143ff704255643ebac1997212edbd5d" STYLE="fork"/>
                        <node TEXT="exit点为cross point.x + 0.5车道宽度，加上自车heading旋转" ID="d0eacbecf535021a8a78b0f6b911fc95" STYLE="fork"/>
                      </node>
                      <node TEXT="crossing的stop_point_s为ego_cross_point.s - 0.5车道宽度" ID="5aedd15dc3e20e5b9971f89b8a6facd2" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="按stop_point_s对crossing从小到大排序" ID="c95d18a2c246465d63e7a6e20ca9f374" STYLE="fork"/>
                  <node TEXT="将crossing转换为junction info" ID="4e4714f959e8138b3b9bc98cac8e91cd" STYLE="fork"/>
                  <node TEXT="junction features" ID="e866786dae74c367f739de72891aa432" STYLE="fork">
                    <node TEXT="" ID="24af4ae5d5bea6e608a04e0d7dd6e5cf" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="crossing的特征提取" ID="bddd6e24f33cc299e04aeb560a107d4d" STYLE="fork">
                  <node TEXT="遍历所有的junction的原始特征" ID="764f21d60092dd70744316d524f011d2" STYLE="fork">
                    <node TEXT="生成自车和obs（只考虑car和truck）的特征" ID="7331854782d4130100534532bfa26718" STYLE="fork"/>
                    <node TEXT="" ID="7d86c523751476f646690505c0a055b5" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="基于规则的模型" ID="8cf92333dfa96c27804b7f55531b133b" STYLE="fork">
                  <node TEXT="" ID="6b356da576756e44d8db6626c1f353cb" STYLE="fork"/>
                  <node TEXT="计算自车当前位置到enter point的ttc" ID="b7fa1d12c7593c1f8ad25d13ca1a32e3" STYLE="fork">
                    <node TEXT="获取自车当前位置到enter point的所有lane segments" ID="3661634ea6a98840046cfa27657db2fc" STYLE="fork"/>
                    <node TEXT="遍历lane segments，计算ttc" ID="3b92e962e965903baa9ba6abd6f399be" STYLE="fork">
                      <node TEXT="计算曲率限速" ID="7caef3118496e9b672b382dcfa6a5040" STYLE="fork">
                        <node TEXT="取头2点，尾2点" ID="8c4cc354e16b9806c45e24619181c6d2" STYLE="fork"/>
                        <node TEXT="弯道半径=中心线的长度s / abs(head_heading - tail_heading)" ID="049ed0b24facbe0da6fc7eb4fed63ea9" STYLE="fork"/>
                        <node TEXT="按照[8m: 5kph, 650m: 120kph]的速度插值得到限速" ID="61985e340d713f0a2e14bb8573e9edf3" STYLE="fork"/>
                      </node>
                      <node TEXT="expect_acc = (限速^2 - ego_v^2)*0.5 / 中心线的长度s" ID="3375b5cd475c1c662cc592a7faa1b302" STYLE="fork"/>
                      <node TEXT="acc = clamp expect_acc在[-2, 2]之间" ID="a4d80c1b1e6661cb19842a1d36c780e5" STYLE="fork"/>
                      <node TEXT="分段计算ttc" ID="2b26919d5d0b766bd96ad150e8304549" STYLE="fork">
                        <node TEXT="target_v = v^2 + 2.0*acc*s" ID="918d225f2a4831c506467f4246c92969" STYLE="fork"/>
                        <node TEXT="若v和target_v都大于限速" ID="f5f1a03fd2e5f4cadfe990630f55a032" STYLE="fork">
                          <node TEXT="ttc = s / ((v + target_v)*0.5)" ID="04f0319c19235c95528bf97210a949c3" STYLE="fork"/>
                        </node>
                        <node TEXT="若target_v大于限速，且v小于限速" ID="848cc648e82837908ebb8c0e3570c473" STYLE="fork">
                          <node TEXT="ttc1 = (限速 - v) / acc" ID="6edf0000bcd506acd15f41112d28838e" STYLE="fork"/>
                          <node TEXT="ttc2 = (s - ((限速^2 - v^2) / (2.0*acc))) / 限速" ID="c312c8d63ec347cce1d65318704d90e8" STYLE="fork"/>
                          <node TEXT="ttc = ttc1 + ttc2" ID="30f13a1cc3e9dabb192f69e6dbe18642" STYLE="fork"/>
                        </node>
                        <node TEXT="若target_v小于限速" ID="b61440e541ddc859326b0e4e02d7d2cc" STYLE="fork">
                          <node TEXT="ttc = s / (0.5*(v + target_v))" ID="a353e0e438aba5d5def8df47eefc42a0" STYLE="fork"/>
                        </node>
                      </node>
                    </node>
                    <node TEXT="enter_time = 累计ttc" ID="a07516523c0c3b3b3a90991b9b8f5023" STYLE="fork"/>
                    <node TEXT="exit_time = (exit_cross_s - enter_cross_s) / v + enter_time" ID="27d396ab1be21964765261c24fd671d1" STYLE="fork"/>
                  </node>
                  <node TEXT="计算obs当前位置到enter point的ttc" ID="a58cea4327e868923f76f3d45c1d81a3" STYLE="fork"/>
                  <node TEXT="time_threshold = ego_enter_time + buffer" ID="aea715759a59ca882682c9b5d397de15" STYLE="fork">
                    <node TEXT="若obs高路权，则buffer为-1s" ID="9eb23a45b81d45f2807ee948a06ec091" STYLE="fork"/>
                    <node TEXT="若obs低路权，则buffer为+1s" ID="b4dbf89098057d52dad6d8ca511f53a2" STYLE="fork"/>
                  </node>
                  <node TEXT="若obs的enter_time大于time_threshold，则为NOT YIELD，否则为YIELD" ID="428dab0f7a8bf83bddd1c6fee44a5933" STYLE="fork"/>
                </node>
                <node TEXT="多crossing决策的仲裁，暂无" ID="3f535e7f6f630b0735d64e0ef0144ead" STYLE="fork"/>
              </node>
              <node TEXT="变道决策" ID="2e1d496ce3a4b203ee2feda4e30fac98" STYLE="fork">
                <node TEXT="自车在变道中" ID="28c9c16862a54bb88451c8e2e63defcf" STYLE="fork">
                  <node TEXT="前后s_range：(-max(5, ego_v)*5s, max(5, ego_v)*5s)" ID="2dcf6ee3cc2813046cda76679cb3e577" STYLE="fork"/>
                  <node TEXT="若为左/右变道，选择左/右车道的目标obs（s_range，前3个，后2个）作为candidates" ID="35c46f513c8d1187620df41753d05e38" STYLE="fork"/>
                  <node TEXT="过滤LC中的candidates" ID="90e647745197b1c581bf5c383c4c3d21" STYLE="fork"/>
                  <node TEXT="遍历candidates，生成变道slot（front, back）" ID="b4130e8421c0533b0acfd09864216db5" STYLE="fork"/>
                </node>
                <node TEXT="自车不在变道中" ID="843b4c558267317b3e46eaa1457ea288" STYLE="fork">
                  <node TEXT="获取自车后方的obs" ID="44bf3caff626d133a49b26905b335e8f" STYLE="fork"/>
                  <node TEXT="过滤obs（仅truck和life time &gt; 700ms）" ID="cd201945daebc4c599677145696e0e57" STYLE="fork"/>
                  <node TEXT="并获取到自车最近的前车，生成变道slot（front, back）" ID="e0ee3233cabd350080cc8e8932f8fec0" STYLE="fork"/>
                </node>
                <node TEXT="lane change的特征提取" ID="c5e6c73ed54a52b2de55d40dbc40eb86" STYLE="fork">
                  <node TEXT="遍历变道slot" ID="534677f3d593a23b781f7d9a02224b13" STYLE="fork">
                    <node TEXT="计算slot_front_obs的obstacle info信息" ID="74f92a657f2aed72a48043fc3898b24b" STYLE="fork">
                      <node TEXT="其中s是相对ego_s" ID="2c01ee3d7acd029df10aebeda872ebb2" STYLE="fork"/>
                      <node TEXT="根据obs的角点计算在target lane上的min_l, max_l, min_s, max_s" ID="e05174a05ef3f34279b00ff96950f708" STYLE="fork"/>
                    </node>
                    <node TEXT="计算slot_back_obs的obstacle info信息" ID="d94c65afaa87e01441c334dc76dc1df8" STYLE="fork"/>
                    <node TEXT="计算自车的ego info信息" ID="0c6d31ec001a06cde17d01a43b3cd6b8" STYLE="fork"/>
                    <node TEXT="" ID="6cc9a221027ec96796feb6ed76912120" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="基于规则的模型" ID="0085bfafa02fac50d013578233605222" STYLE="fork">
                  <node TEXT="遍历变道slot" ID="3cae89ab9c2fdbf5c02ccd95d8d78863" STYLE="fork">
                    <node TEXT="若front_s &gt; ego_s，且back_s &lt; ego_s，则slot的概率为1" ID="f210570dde13a45e214a5d08258d95e7" STYLE="fork"/>
                    <node TEXT="其他，则slot的概率为0" ID="ab497ce1aef4d7a45996f1862c10a2a2" STYLE="fork"/>
                  </node>
                </node>
              </node>
              <node TEXT="ool nudge决策" ID="6659c15dfcb8ed99ec7bbdfb1237ded0" STYLE="fork">
                <node TEXT="获取自车前后的obs作为候选obs" ID="f1ecac99ce9e5b4d222378c4240f6b93" STYLE="fork"/>
                <node TEXT="遍历候选obs" ID="e2c37c4aa3647af1e767c6dbcd97619b" STYLE="fork">
                  <node TEXT="忽略vru（类型为3或4）" ID="2c3968ff1fc03db95ac42ce6d090f2ab" STYLE="fork"/>
                  <node TEXT="若obs不为nudge obs，且上次为左nudge，obs_l + 0.5车宽 &lt; -1m，则忽略" ID="adb6d6ae2497a29c57d452e8443dcb5f" STYLE="fork"/>
                  <node TEXT="若obs不为nudge obs，且上次为右nudge，obs_l - 0.5车宽 &gt; 1m，则忽略" ID="a0b4b78d015ee083a8b8bd140c8c4ab3" STYLE="fork"/>
                </node>
                <node TEXT="ool nudge的特征提取" ID="6c06af6bdd1cfdb372a63561566af5e2" STYLE="fork">
                  <node TEXT="遍历候选obs" ID="7e3761c909104df687216d444aea25fa" STYLE="fork">
                    <node TEXT="计算候选obs的obstacle info信息" ID="249fea02c650c674e225eae64ec48aac" STYLE="fork"/>
                  </node>
                  <node TEXT="计算自车的ego info信息" ID="29301f7201e2685dcc7189a5dc0c56ba" STYLE="fork"/>
                </node>
                <node TEXT="基于规则的模型" ID="711e9c35b07d1ef23bcc687fd67202c7" STYLE="fork">
                  <node TEXT="若在nudge过程中" ID="10eac570fe941d2821e838e3cec0d8e5" STYLE="fork"/>
                  <node TEXT="未在nudge过程中" ID="a1875cf2847c2d6a78164bc3486a917b" STYLE="fork">
                    <node TEXT="确定nudge的threshold" ID="8f9b054969f8648870cf25c981a08f9e" STYLE="fork"/>
                    <node TEXT="若为左nudge" ID="145c58110e3b80a8dae4a41f1873a84a" STYLE="fork">
                      <node TEXT="left_ignore_thresh = -2.5m" ID="245aca394496d1537c6d19a6209c7fc1" STYLE="fork"/>
                      <node TEXT="yield_left_nudge_thresh = max(left_ignore_thresh, 左车道nudge lateral offset - 0.5m)" ID="0f7edc2755687a47954c7f8df7bdc360" STYLE="fork"/>
                      <node TEXT="yield_right_nudge_thresh = 左车道nudge lateral offset + 0.5m" ID="1ca8626533d9a03e8d67c7b2831bbb16" STYLE="fork"/>
                      <node TEXT="right_ignore_thresh = yield_right_nudge_thresh + 2.5m" ID="fcb3dda5f31f9a9bfe8fc566d8a8c4e3" STYLE="fork"/>
                    </node>
                    <node TEXT="若为右nudge" ID="637db25262a34a875826ab879002d0a8" STYLE="fork">
                      <node TEXT="right_ignore_thresh = 2.5m" ID="2bf8d85c4cfd7d00b04555769ef0bb0f" STYLE="fork"/>
                      <node TEXT="yield_right_nudge_thresh = min(right_ignore_thresh, 右车道nudge lateral offset + 0.5m)" ID="0fcab6ec69f985f3c2e63cf85c215764" STYLE="fork"/>
                      <node TEXT="yield_left_nudge_thresh = 右车道nudge lateral offset - 0.5m" ID="d717b71aaf12d9c5f48d7b4135f0c85f" STYLE="fork"/>
                      <node TEXT="left_ignore_thresh = yield_left_nudge_thresh - 2.5m" ID="21f45c69b890003f3e0abc7ecbb9a229" STYLE="fork"/>
                    </node>
                    <node TEXT="遍历候选obs" ID="bb8f49be8ae41b54da65998e02d55929" STYLE="fork">
                      <node TEXT="若obs_max_l &lt; left_ignore_thresh或obs_min_l &gt; right_ignore_thresh，则加入ignore集" ID="5891de029f20a395de11ea9c58595f61" STYLE="fork"/>
                      <node TEXT="若obs_max_l &lt; yield_left_nudge_thresh" ID="5e9deaf5072c04106a96053ce67302f8" STYLE="fork">
                        <node TEXT="上次非向左nudge，且obs_max_s &lt; ego_min_s，则加入ignore集" ID="d8e1a209e216d6f1acd59e86f0dbe77a" STYLE="fork"/>
                        <node TEXT="其他，则加入left nudge集" ID="a3c3e1f54b0ba98939a68057fdde4d41" STYLE="fork"/>
                      </node>
                      <node TEXT="若obs_min_l &lt; yield_right_nudge_thresh" ID="ede4bd6b63926751bda6728315b8f393" STYLE="fork">
                        <node TEXT="obs_max_s &lt; ego_min_s，则加入ignore集" ID="4d234771e1e5e7e4538b8702b25eeff1" STYLE="fork"/>
                        <node TEXT="其他，则加入yield集" ID="1cb876454c9aeb5985b9d4cc872a9a42" STYLE="fork"/>
                      </node>
                      <node TEXT="其他" ID="479059ac5a52e36de078b810da73fff3" STYLE="fork">
                        <node TEXT="上次非向左nudge，且obs_max_s &lt; ego_min_s，则加入ignore集" ID="4bb6e9049ca670e00580a56f53649d49" STYLE="fork"/>
                        <node TEXT="其他，则加入right nudge集" ID="9ce08495f75bf7a7dfc9a5cff6040a87" STYLE="fork"/>
                      </node>
                    </node>
                    <node TEXT="若是向左/右nudge" ID="2fb5956a18364af832874ef6ad8d66dc" STYLE="fork">
                      <node TEXT="对left/right nudge集的obs按照s从小到大排序" ID="e9256110412946acb12fcfabb32d53a8" STYLE="fork"/>
                      <node TEXT="check是否安全回到原车道" ID="1b887cc2f8a54f4d8cb1f6518d8f23f8" STYLE="fork">
                        <node TEXT="safety_lateral_threshold" ID="1d668b8b6ba2220352b2801b87a08a97" STYLE="fork">
                          <node TEXT="向左nudge，fabs(nudge_obs_max_l) + 0.5自车宽度" ID="df04a1d57f8bef0a8e9c58c42f36c684" STYLE="fork"/>
                          <node TEXT="向右nudge，fabs(nudge_obs_min_l) + 0.5自车宽度" ID="56af512e8b928bb973e8dab812f29b00" STYLE="fork"/>
                        </node>
                        <node TEXT="在left/right nudge集中找最近前车（obs_s &gt; ego_min_s）及其后车" ID="01be8a475ca0c0bd82650a676716c9a9" STYLE="fork"/>
                        <node TEXT="check前车功能安全" ID="9f0c7dd221663a2a3b0dcfe0acebe533" STYLE="fork">
                          <node TEXT="ratio = ego_l / safety_lateral_threshold" ID="65b44442353e483bada9f4182f0534ac" STYLE="fork"/>
                          <node TEXT="若前车车速&lt;1m/s，且front_s - ego_max_s &lt; 20m，则不安全" ID="86092fd6a403d9cc6a962094937de887" STYLE="fork"/>
                          <node TEXT="其他" ID="e821c229f4f61e0f49a025cef72f962d" STYLE="fork">
                            <node TEXT="若ego_v &gt; front_v" ID="49c03ccb3b2f3e5a72d2a3aad91ad8f8" STYLE="fork">
                              <node TEXT="safety_distance = (0.5*(ego_v - front_v)^2 / 0.9m/s2 + 3m)*ratio" ID="299dd154450942f7c6d452aea1ff208e" STYLE="fork"/>
                            </node>
                            <node TEXT="否则" ID="6cb3f4b5a7c924765546d9b1a25f8b4d" STYLE="fork">
                              <node TEXT="safety_distance = 3m * ratio" ID="5d709de3bfaa023e5dcabccfd3323b03" STYLE="fork"/>
                            </node>
                            <node TEXT="若front_s - ego_max_s &lt; safety_distance，则不安全，否则安全" ID="08ae941657b7c79e6177b87178de4a00" STYLE="fork"/>
                          </node>
                        </node>
                        <node TEXT="check后车功能安全" ID="5ac46c1e657ff6790093243c1c33dfeb" STYLE="fork">
                          <node TEXT="若back_v &gt; ego_v" ID="ef773de0e7a675d5584efbfcf76ed15d" STYLE="fork">
                            <node TEXT="safety_distance = (back_v - ego_v)*3s + 6m" ID="78b0dafe486d4f90384fca1354b93900" STYLE="fork"/>
                          </node>
                          <node TEXT="否则" ID="4d88a45482ac867de6232a8d896eb19f" STYLE="fork">
                            <node TEXT="safety_distance = 6m" ID="790ccf689e0eff89198df30ca63ebf33" STYLE="fork"/>
                          </node>
                          <node TEXT="若ego_min_s - back_max_s &lt; safety_distance，则不安全，否则安全" ID="95a722fee649f3108365bd6eb8161922" STYLE="fork"/>
                        </node>
                        <node TEXT="仅在前后都满足功能安全，才能安全回到原车道" ID="dee92e85fc174f7f9cbb1f3f37228184" STYLE="fork"/>
                      </node>
                      <node TEXT="是否正在超车（ego_min_s &gt; nudge_max_s）" ID="4509f14515ddcfc444356ce6bfb96732" STYLE="fork"/>
                      <node TEXT="若安全回到原车道且正在超车" ID="e80cc72171970c767e92835dfeaa8c84" STYLE="fork">
                        <node TEXT="根据nudge的方向、横纵向的位置，更新yield集、left_nudge集、right nudge集" ID="7f84192a7b5d0b78c9ca32a86e5e561a" STYLE="fork"/>
                      </node>
                      <node TEXT="否则，细化nudge决策" ID="30a51b8621c2fc089ef3e5d78e9e039a" STYLE="fork">
                        <node TEXT="遍历left nudge集" ID="4eeb7381f98186b7292e96576977156d" STYLE="fork">
                          <node TEXT="遍历right nudge集" ID="0a8db7090ee4ace51ee5cd9c4fb1c44b" STYLE="fork">
                            <node TEXT="若left_obs_min_s - right_obs_max_s &gt; 自车长度，或right_obs_min_s - left_obs_max_s &gt; 自车长度，则过滤" ID="4079f882841c501a4a04c3af649c180d" STYLE="fork"/>
                            <node TEXT="lateral_buffer = 0.8m（锥桶为0.5m）" ID="75d4dccc347f8051a17d92360faaecd0" STYLE="fork"/>
                            <node TEXT="若right_obs_min_l - left_obs_max_l &gt; 自车宽度+lateral_buffer，则过滤" ID="94ef62fa132a849b0dd6fa1f01d9cfd2" STYLE="fork"/>
                            <node TEXT="根据left和right obs的静止状态（小于1m/s），nudge静止obs，yield运动obs，调整对应的集合" ID="0da59087af4e6502483c098313cf2dac" STYLE="fork"/>
                          </node>
                        </node>
                        <node TEXT="最终的target_nudge_lat_offset" ID="3ea451019d95cbcf3bfb60ee85ff4e52" STYLE="fork">
                          <node TEXT="向左nudge，则为前车max_l + 2m" ID="87828c0a13f662817330a74251212489" STYLE="fork"/>
                          <node TEXT="向右nudge，则为前车min_l - 2m" ID="5c90016a485440c92413e965918aa64b" STYLE="fork"/>
                        </node>
                      </node>
                    </node>
                  </node>
                  <node TEXT="计算风险限速" ID="ab8135d240776580599d46aabced5400" STYLE="fork">
                    <node TEXT="遍历nudge决策信息" ID="8c925da990bc1f9a285063c708bbacd5" STYLE="fork">
                      <node TEXT="acc = 2m/s2" ID="0eac6b9390345c52e1865e5d75e892eb" STYLE="fork"/>
                      <node TEXT="按照3s，分辨率为0.5s" ID="dc80446748b5e53b421970daf747d668" STYLE="fork">
                        <node TEXT="按frenet上的ca模型计算nudge obs和ego的s, l" ID="c3cc389d6e468df94f6a44ed4b06f402" STYLE="fork"/>
                        <node TEXT="lat_dist = abs(ego_l - obs_l) - 0.5自车宽度 - 0.5obs宽度" ID="5d7faa1ad4fb3bc50d98e3c7768af759" STYLE="fork"/>
                        <node TEXT="找到最小的lat_dist" ID="2fb1470471e0bebf526289e1090e1672" STYLE="fork"/>
                      </node>
                      <node TEXT="计算限速" ID="48072ef07ec89d128de188e067605c6f" STYLE="fork">
                        <node TEXT="若为行人" ID="5754d7dd5190656f1b76358519d8b758" STYLE="fork">
                          <node TEXT="若min_lat_dist小于1.5m，限速为10kph" ID="faa0e5614ce5e1651b004c7badc2a2af" STYLE="fork"/>
                          <node TEXT="若min_lat_dist小于5m，按照横向距离插值得到限速" ID="dca4d2e8a7c7610948ee040ca4bcbcaf" STYLE="fork">
                            <node TEXT="低速（10kph）横向距离：1.5m" ID="3488059add89eade3147a92d5b0ae48e" STYLE="fork"/>
                            <node TEXT="高速（140kph）横向距离：5m" ID="0684bec6a9547bf2db555124f4a5fc46" STYLE="fork"/>
                          </node>
                        </node>
                        <node TEXT="其他，若obs_v小于0.5m/s" ID="a3bddb28a58db4556e3372007d12f4bf" STYLE="fork">
                          <node TEXT="若min_lat_dist小于0.5m，限速为15kph" ID="4a99185b9398c278bb0057778f248bd9" STYLE="fork"/>
                          <node TEXT="若min_lat_dist小于5m，按照横向距离插值得到限速" ID="79633fd6e6cae18588a0e7a980d33761" STYLE="fork">
                            <node TEXT="低速（15kph）横向距离：0.5m" ID="fcfa1062a2f16834efd0347a04492fb7" STYLE="fork"/>
                            <node TEXT="高速（60kph）横向距离：2m" ID="6e7d9e222dc09f1c05a75fbab6d511e2" STYLE="fork"/>
                          </node>
                        </node>
                      </node>
                    </node>
                  </node>
                </node>
              </node>
              <node TEXT="决策冲突检测和解决（lane keep, lane change, merge, ool nudge）" ID="44870279818408b13f687f3c23eac90a" STYLE="fork">
                <node TEXT="对同一个agent检测决策是否冲突" ID="bfe885b9079204b8e4686f41fd1fd55d" STYLE="fork">
                  <node TEXT="决策有RISK，则不冲突" ID="206e83997420017f1cfaa09668423904" STYLE="fork"/>
                  <node TEXT="YIELD和NOT YIELD冲突" ID="f281f6a71926cd63851cd798ce07ed43" STYLE="fork"/>
                  <node TEXT="YIELD和LEFT NUDGE冲突" ID="f0622b70f8ed2d87b1c177cd84b35aa8" STYLE="fork"/>
                  <node TEXT="YIELD和RIGHT NUDGE冲突" ID="6e4fcee3627b085288317a8a6bf03d12" STYLE="fork"/>
                  <node TEXT="ool nudge和其他冲突" ID="cdf9096e95e2f4246890671e201badb6" STYLE="fork"/>
                </node>
                <node TEXT="冲突解决" ID="3b41d34f02464aaa481f5e8085d48059" STYLE="fork">
                  <node TEXT="lane keep为NOT YIELD，但lane change/merge为YIELD，则去除lane keep决策" ID="8f65ad0206d4ff99a6decff856a77422" STYLE="fork"/>
                  <node TEXT="lane keep为YIELD，但lane change/merge为NOT YIELD，则去除lane change/merge决策" ID="97ae3416bc8bef49372584e608b7cbe1" STYLE="fork"/>
                  <node TEXT="lane keep为LEFT NUDGE或RIGHT NUDGE，但lane change/merge为YIELD，则去除lane keep决策" ID="dd11b213dc016de761a9e519867204d6" STYLE="fork"/>
                  <node TEXT="merge和lane change冲突，则去除lane change决策" ID="89a63442ee3b2ed1f82a7bbe1f458861" STYLE="fork"/>
                  <node TEXT="ool nudge和其他冲突，则去除其他决策" ID="09d332d90f126aa939e0fcc3aae306c8" STYLE="fork"/>
                </node>
              </node>
            </node>
            <node TEXT="根据dt计算agents的下一时刻的状态" ID="de7c77e895125cf5007340612aa6ee56" STYLE="fork">
              <node TEXT="遍历fs agents" ID="39b2084b4cdfcf12126af779589e8126" STYLE="fork">
                <node TEXT="若为自车，计算target steer, velocity及desired state" ID="009d9a03926131dac04939b80057eb96" STYLE="fork">
                  <node TEXT="通过improved pure pursuit计算target steer" ID="5dd5665af6f2e2040dd3638acd0276c7" STYLE="fork">
                    <node TEXT="look ahead" ID="ce2772e469d2ed4a3af732a17b7fa979" STYLE="fork">
                      <node TEXT="x = ego_v * 1.5s，clamp在[7m, 50m]" ID="b8d368190541ba2fa72d329c54051989" STYLE="fork"/>
                      <node TEXT="y 为ool nudge的横向offset" ID="fa416e53abe7cb5ef5710fb47ce36843" STYLE="fork"/>
                    </node>
                    <node TEXT="" ID="bd2e57d62e8a411051d6a9e47ef5bf08" STYLE="fork"/>
                  </node>
                  <node TEXT="通过idm计算target velocity" ID="e27809b2ce27902675d467e5addd83fb" STYLE="fork">
                    <node TEXT="若" ID="fc4016d270cfc4228d9f28f7f491ff1a" STYLE="fork"/>
                  </node>
                  <node TEXT="使用idea steer model更新state" ID="913c4d0053e3683c593e00c32151f2ab" STYLE="fork">
                    <node TEXT="param" ID="725a36ab011f40623b9944d832f79fcd" STYLE="fork">
                      <node TEXT="max_lon_acc_jerk 5.0m/s3" ID="c22172da4181ca002eb423a36e6adb51" STYLE="fork"/>
                      <node TEXT="max_lon_brake_jerk 5.0m/s3" ID="27295cf71e48684d20d6d90dacb7e406" STYLE="fork"/>
                      <node TEXT="max_lat_jerk_abs 3.0m/s3" ID="84d50e9581ff08a5065dbbde99def469" STYLE="fork"/>
                      <node TEXT="max_lat_acc_abs 1.5m/s2" ID="ca2c45ad2f5820bb76a4dd62276ed0ae" STYLE="fork"/>
                      <node TEXT="max_steer_angle_abs 60°" ID="84b9745926536fb7994812c3044c40c1" STYLE="fork"/>
                      <node TEXT="max_steer_rate 22.34°/s" ID="0ef01116ab597cb53ad1fd354c2dee94" STYLE="fork"/>
                    </node>
                    <node TEXT="desired state" ID="6fb31e7977fe286e2182b21fe2182891" STYLE="fork">
                      <node TEXT="desired_lon_acc = (target_velocity - ego_v) / dt" ID="7ca1f398b0669bd3fca3473aa4c80cbb" STYLE="fork"/>
                      <node TEXT="desired_lon_jerk = (desired_lon_acc - acc) / dt" ID="50fb84ea6626bee7e0f1832000ef2214" STYLE="fork"/>
                      <node TEXT="desired_velocity = ego_v + desired_lon_acc * dt" ID="87fa405df3c882fa5250c04116ddb729" STYLE="fork"/>
                      <node TEXT="desired_lat_acc = sqrt(desired_velocity) * (tan(target_steer) / wheelbase_len)" ID="e4eb238b62973175f829bde7ac1d0fe7" STYLE="fork"/>
                      <node TEXT=" lat_acc_ori = sqrt(ego_v) * curvature" ID="6300cacd954c0625f01972c6cf88e67e" STYLE="fork"/>
                      <node TEXT="desired_lat_jerk = (desired_lat_acc - lat_acc_ori) / dt" ID="272d3e33fd530c5cd77f5decf6d6b791" STYLE="fork"/>
                      <node TEXT="desired_lat_acc = lat_acc_ori + desired_lat_jerk * dt" ID="07da6de796d983fb80674cfdd10a2d02" STYLE="fork"/>
                      <node TEXT="desired_steer = atan(desired_lat_acc * wheelbase_len / desired_velocity)" ID="d675d1c1e649a57d01844cdf4a3d1018" STYLE="fork"/>
                      <node TEXT="desired_steer_rate = (desired_steer - ego_steer) / dt" ID="e2ddd23b87ed852f5e8ae456224643f7" STYLE="fork"/>
                    </node>
                  </node>
                </node>
              </node>
            </node>
            <node TEXT="评价" ID="a7681b8c6421c14358c382a1536f4bbe" STYLE="fork">
              <node TEXT="做严格的功能安全check" ID="bf229612b5405b65408264441c693eb0" STYLE="fork">
                <node TEXT="遍历fs agents" ID="7dc2ee267bfac38f22bebc5ed21d8ae6" STYLE="fork">
                  <node TEXT="计算agent和自车是否发生碰撞，按照2d bbox求overlap" ID="560a247279bc2ea81b9a72063ac442ad" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="计算cost" ID="faea7c679879ca108dcd9267d2ab1d65" STYLE="fork">
                <node TEXT="计算自车的效率cost" ID="110cb1023235a497cd9c3c26bf628dfb" STYLE="fork">
                  <node TEXT="v_weight = desired_velocity - ego_v" ID="5228bc3cb667fc6e4958ada293fea231" STYLE="fork"/>
                  <node TEXT="cost = -v_weight * exp(-ego_v / 10) * 0.3" ID="b220d5e95d9f2f19aac889b1463bed3f" STYLE="fork"/>
                </node>
                <node TEXT="计算导航cost" ID="3b25f17c286d3966d08ebfcaa10e83c4" STYLE="fork">
                  <node TEXT="计算累计横向offset" ID="fc6c5602e5e6c83b7fc9744f15d9b61e" STYLE="fork">
                    <node TEXT="多帧计算自车的横向offset" ID="bbd951c76c3a1cf725c87da598bea880" STYLE="fork">
                      <node TEXT="仅在LK场景下计算" ID="050d8caf8e303d377677ff1782719553" STYLE="fork"/>
                      <node TEXT="若自车的l在左/右边界以内，则返回其l" ID="32c84ef4414affd6e5ca61025f39df22" STYLE="fork"/>
                      <node TEXT="累计l" ID="dab6e9a037ad5985dd1dfd1c9f3cdde6" STYLE="fork"/>
                    </node>
                    <node TEXT="计算变道的cost" ID="8e8377e9c4eac67f402aa0954e7c817e" STYLE="fork">
                      <node TEXT="根据left, mid, right的优先级、车道限速、remain_s（45s*限速）来综合计算" ID="82c4ce9f7867f2cfd331e254373f24de" STYLE="fork"/>
                    </node>
                    <node TEXT="计算ool nudge的cost" ID="5073fc84e8a9ae2c22bff1474cd6c0b5" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="计算utility的cost" ID="589b036917e75ee121a3f9e33d5c61ea" STYLE="fork"/>
              </node>
            </node>
          </node>
        </node>
        <node TEXT="MP" ID="85c445b18a6aa0000ecd13a3729a4e3b" STYLE="fork">
          <node TEXT="轨迹边界决策" ID="5d1670c3e29128d7b627f5c9430ceb95" STYLE="fork">
            <node TEXT="纵向规划的path长度 = clamp(8s*ego_v + 0.5*2m/s2*8s^2, (50m, 参考线长度-10m))" ID="ff1bfef16e6187f52189fbcc846182a2" STYLE="fork"/>
            <node TEXT="更新road edge" ID="b96b5b372f8f4e41c34c4a50ea8aae35" STYLE="fork">
              <node TEXT="从dynamic map激活左右road edge" ID="165e8093e5ad088edfd1b9d9aeadf46d" STYLE="fork">
                <node TEXT="若距离split点小于250m，则不激活road edge" ID="53e3dfe65626d293383c27f622b2e4f4" STYLE="fork"/>
                <node TEXT="仅使用cement block、fence、wallflat类型的road edge" ID="b49be4e7080166463672768468ebccdb" STYLE="fork"/>
                <node TEXT="计算平均曲率，若平均曲率大于0.005，则不激活" ID="db6740aff16eba6e0bc710a645ef3140" STYLE="fork">
                  <node TEXT="计算dy, ddy" ID="83b1e4c74cd212419c1f2a0a310452e5" STYLE="fork"/>
                  <node TEXT="curvature = ddy / (1 + dy^2) ^ 1.5" ID="c2e2133ef996cc73cf24e5d1c3acdca8" STYLE="fork"/>
                </node>
                <node TEXT="check life time，若小于3s，则不激活" ID="48c42a8b26beee91417623616edf9272" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="更新obs的FS信息" ID="54751deafcef9d97648a71e915ed49be" STYLE="fork">
              <node TEXT="" ID="1d8b1bf2ccce498552a8f8965cac5970" STYLE="fork"/>
              <node TEXT="更新static obs（obs_v &lt; 0.5m/s）信息（角点，id，type）" ID="5b2477e483346ac683f27c70ce58e18b" STYLE="fork"/>
              <node TEXT="更新dynamic obs信息（id，type，轨迹（角点））" ID="9fa690ad49f0267470d51904a4059134" STYLE="fork">
                <node TEXT="根据自车规划的时间采样进行插值" ID="03b83d6618939823b4fbf77ff7065b21" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="LK obs选择" ID="3b3b313c5f375c3ff1e666f270f7af4e" STYLE="fork">
              <node TEXT="合并决策结果" ID="f4819f2f19fe05ea80d497009ddd1721" STYLE="fork">
                <node TEXT="lane keeping的obs（yield或not yield）" ID="b39318ef7ed5473cc3eef57fc9b401d8" STYLE="fork"/>
                <node TEXT="vru obs（yield或not yield）" ID="2f656701e19081a293c67ed5ad76012e" STYLE="fork"/>
                <node TEXT="路口crossing按enter点的时间yield" ID="dbc0f80c5490f9451b9c82e481a08712" STYLE="fork"/>
              </node>
              <node TEXT="构建ST boundary" ID="f43258c813998ffd2074fcb61320ab36" STYLE="fork">
                <node TEXT="boundary point" ID="028b769c21ead98373aa502a74886b12" STYLE="fork">
                  <node TEXT="" ID="713f34f4253e812a9e4d7cf3b501ce06" STYLE="fork"/>
                </node>
                <node TEXT="对于yield、vru_yield（把3m的buffer扣除）、crossing_yield按min_s更新st boundary的ub" ID="a2800b1e8b1d3a4e2a1522dada196eb6" STYLE="fork"/>
                <node TEXT="蠕行状态" ID="f0f5236b582a640c6c41a5246f1596f8" STYLE="fork">
                  <node TEXT="进入蠕行（自车车速小于3.0m/s，前车车速小于2.5m/s，和前车的距离小于15m），退出蠕行（自车车速大于3.3m/s，前车车速大于3.5m/s）" ID="5b8adfd4308fb74ed1950365c4f39e67" STYLE="fork"/>
                </node>
              </node>
            </node>
            <node TEXT="LK的obs的横向nudge决策（对于dynamic obs和static obs）" ID="636304074332436534d8b10e933afb44" STYLE="fork">
              <node TEXT="nudge白名单（行人，bike，car，truck，psp锥桶）" ID="40807872f526205d6168045514262fa1" STYLE="fork"/>
              <node TEXT="若ego_l &lt; obs_min_l，则为向右nudge，若ego_l &gt; obs_max_l，则为向左nudge" ID="f9e2ac81a4a21c83b2e0b4628f9449e1" STYLE="fork"/>
              <node TEXT="纵向距离check" ID="8210f316edff86b3a38ac304119e4e99" STYLE="fork">
                <node TEXT="lon_range = clamp(0.8s自车车速, (2m, 30m))" ID="c9313efbc92b957785e8a6a194d60fad" STYLE="fork"/>
                <node TEXT="若ego_min_s - lon_range &gt; obs_max_s，则忽略" ID="90e40db3d463abbb7bc0d7d4ea0ece69" STYLE="fork"/>
                <node TEXT="若ego_max_s + lon_range &lt; obs_min_s，则忽略" ID="804cf80fae3b8403b20804d3f38f2377" STYLE="fork"/>
                <node TEXT="若lat_move / (obs_min_s - ego_s - 2m) &gt; 0.3，则yield" ID="c8be7a2b0ca7c123918543515929312a" STYLE="fork"/>
              </node>
              <node TEXT="横向距离check" ID="1f6046c4c5f9e96f0c38c4d71ca4735b" STYLE="fork">
                <node TEXT="若向左nudge，obs_min_l &lt; 0.5车宽，则yield" ID="2e4aa2340a4262ac83ab6923217f2b3c" STYLE="fork"/>
                <node TEXT="若向右nudge，obs_max_l &gt; -0.5车宽，则yield" ID="b14ab17b6c54ea5a1fbe423cdd40ef9b" STYLE="fork"/>
              </node>
              <node TEXT="其他，则为nudge" ID="e8a1e335a80a4a73e1bb2eaeb1499700" STYLE="fork"/>
            </node>
            <node TEXT="merge slot的横向nudge决策" ID="ea92482c260e772153961389b4391f25" STYLE="fork">
              <node TEXT="nudge白名单（行人，bike，car，truck）" ID="b73da89a3367ce3d924ac3bf6535d23c" STYLE="fork"/>
              <node TEXT="针对slot的front obs进行横向nudge决策，满足则为merge_yield" ID="4a1beb5e137984852209666cfa842726" STYLE="fork"/>
              <node TEXT="对slot的back obs，策略为merge_overtake" ID="53e762ce4620f5cb63be9abbfc25508f" STYLE="fork"/>
            </node>
            <node TEXT="生成obs的decision region" ID="ea64f9c60bbdf907f559fa769a088827" STYLE="fork">
              <node TEXT="提取路口作为虚拟obs，策略为cross yield" ID="4565afcbec5b21684f1d50301756d5d3" STYLE="fork"/>
              <node TEXT="变道的slot" ID="64cc46bf52aaaa215a488dcfe8a65d89" STYLE="fork">
                <node TEXT="如果是安全变道，则将front obs策略为slot yield，将back obs策略为slot not yield" ID="3463ce7375c41cae8a48efce13c83136" STYLE="fork"/>
                <node TEXT="如果不是安全变道，则将front obs策略为align yield，将back obs策略为align not yield" ID="093a90ca70156731708b150aede32f89" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="构建slt boundary" ID="789269de81bb222de4c4e6c5a9fdf89b" STYLE="fork">
              <node TEXT="ST硬边界" ID="b2548762d248437623a42018121c800b" STYLE="fork">
                <node TEXT="" ID="abf6e4aea9a22947985f49ac6ab3e24e" STYLE="fork"/>
                <node TEXT="" ID="9fb7c7363daa41b80eee3e41866efd5c" STYLE="fork"/>
              </node>
              <node TEXT="ST软边界" ID="f819d5adf83e7157d5388efad673f07a" STYLE="fork">
                <node TEXT="" ID="2d671b504565d7609dc1d1533d8db922" STYLE="fork"/>
              </node>
              <node TEXT="SL硬边界" ID="9496ecd7eaccd97c1f7e069cdbceabe8" STYLE="fork">
                <node TEXT="" ID="e32a17080f6b6bca9a8c8d4ab559208f" STYLE="fork"/>
              </node>
              <node TEXT="SL软边界" ID="13d1f2e93cb0988fac0988462f332fe7" STYLE="fork">
                <node TEXT="" ID="106c72133865ea7f2ee2327c50c3c9e4" STYLE="fork"/>
              </node>
              <node TEXT="遍历t时刻，取其对应的obs decision regions" ID="8cfc4e5894d5d59343e954bd88866bf7" STYLE="fork">
                <node TEXT="遍历obs decision regions" ID="9311df3661ca41de94b721c684c05b85" STYLE="fork">
                  <node TEXT="若为yield，则加入作为st硬边界和st软边界" ID="68e2db0e445b5cd216e6640314d497d2" STYLE="fork">
                    <node TEXT="计算overlap及其时刻（l_distace / l_speed）" ID="52b9569cd475d935cd8e6ea1f5a314fa" STYLE="fork"/>
                    <node TEXT="若ego_min_l &lt; obs_max_l，且ego_max_l &gt; obs_min_l，则为following" ID="bcd0489867dbfadb646f1b7d71b8c9ac" STYLE="fork"/>
                    <node TEXT="更新st硬边界的条件（若min_s小于ub）" ID="9df6a449804a3c6c7f04e155ecfcfa2d" STYLE="fork">
                      <node TEXT="不在lane keep" ID="5e962a2045e7991b9f16141d9bb818c1" STYLE="fork"/>
                      <node TEXT="不为following" ID="3bf05c9a710c4439f18c17e66136bb3f" STYLE="fork"/>
                      <node TEXT="nudge_to_yield" ID="0ca0071b637101d46f0435497069da45" STYLE="fork"/>
                      <node TEXT="不是merge的obs" ID="68a95f37e6631b7c47acbbd0d6b3b48d" STYLE="fork"/>
                      <node TEXT="静止obs" ID="6256eb126bd193230502385d237886dc" STYLE="fork"/>
                      <node TEXT="纵向距离&lt;0.5s thw，当前时刻大于overlap时刻" ID="48712e18b2771a1052adcfb1b4b7eaed" STYLE="fork"/>
                    </node>
                    <node TEXT="增加st软边界" ID="6862534a45624a7e86af00bceae3891e" STYLE="fork">
                      <node TEXT="" ID="9fce86739114bd681eb61941e9e3ad2f" STYLE="fork"/>
                      <node TEXT="thw = clamp(0.1s*ego_v, (1.0s, 1.5s))" ID="976f161a89ce51445d8586a98bb1fa59" STYLE="fork"/>
                      <node TEXT="ttc = 2.0s" ID="0813b4ae335fc5b1280ec717547899b8" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="若为vru yield，则加入作为st硬边界（若min_s小于ub）" ID="2a20cf9c09b8651e466fe83bf39ad146" STYLE="fork">
                    <node TEXT="减去3m的buffer" ID="ba112ecbb262b86426a1a986b5578aff" STYLE="fork"/>
                  </node>
                  <node TEXT="若为slot not yield，则加入作为st软边界" ID="bfffd9808fb8d58942a8799c7a5aa3a8" STYLE="fork">
                    <node TEXT="bnd_position = max_s" ID="8ce2f9831758d840da9c04095c695f6e" STYLE="fork"/>
                    <node TEXT="thw = clamp(0.1s*ego_v, (1.0s, 1.5s))" ID="2f12b81325c78f05e926804ac5cd6b30" STYLE="fork"/>
                    <node TEXT="ttc = 2.0s" ID="4229f44819a8a1e2e5df377f6b181c98" STYLE="fork"/>
                  </node>
                  <node TEXT="若为slot yield，则加入作为st硬边界和st软边界" ID="b62631f39a730b5eeb5e3993adf512cd" STYLE="fork">
                    <node TEXT="更新硬边界（若min_s小于ub）" ID="f0e11ea4a63a4f3893c06837db202db3" STYLE="fork"/>
                    <node TEXT="增加st软边界" ID="6a5edc746203c39d9144c14ae78d509a" STYLE="fork">
                      <node TEXT="thw = ttc = 0.0s" ID="25750e14da3b6248116276df63c0a595" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="若为merge yield，则加入作为st硬边界和st软边界" ID="ca599f56215c655646ce8c5b1d2cc618" STYLE="fork">
                    <node TEXT="更新st硬边界（若min_s小于ub）" ID="44aea255b7017d2bc178213e76ff1378" STYLE="fork"/>
                    <node TEXT="增加st软边界" ID="45469dd1d641ec51a5ca23fa3b775bb0" STYLE="fork">
                      <node TEXT="若min_s大于到conflict point的距离，为yield" ID="a9e701925b149d28a64f6e83239f96c7" STYLE="fork">
                        <node TEXT="thw = clamp(0.1*ego_v, (1.0s, 1.5s))" ID="e4ffdc2fd1d38b07d5700f98258251cb" STYLE="fork"/>
                        <node TEXT="ttc = 2.0s" ID="af39222630633e8edb5a57a59671e25a" STYLE="fork"/>
                      </node>
                      <node TEXT="若min_s小于到conflict point的距离，增加conflict点作为软边界" ID="3df20ebc67c1bbd618264480301a1da6" STYLE="fork">
                        <node TEXT="bnd_position = 到conflict point的距离" ID="65debd84bdd598525565b5056ec54be5" STYLE="fork"/>
                        <node TEXT="thw = 1.0s" ID="57fc49029ec8bbddf774e8c8f328bf27" STYLE="fork"/>
                        <node TEXT="ttc = 0.0s" ID="5e5759fcf68a35a0886b2950929c2c11" STYLE="fork"/>
                      </node>
                    </node>
                  </node>
                  <node TEXT="若为merge overtake，则加入作为st软边界" ID="d446f7932cff2534626f5a1af1bbb61b" STYLE="fork">
                    <node TEXT="增加st软边界" ID="8262049e87a47366faa689f1c484f12c" STYLE="fork">
                      <node TEXT="若obs_min_s大于ego_s + 1.0s*ego_v，则忽略" ID="a07c95708cb556a0e953793254d8ded9" STYLE="fork"/>
                      <node TEXT="计算overtake_bound（jerk ub(1.5m/s3), acc ub(1.5m/s2)）" ID="2f598de5982181c46a01de903909ecbb" STYLE="fork">
                        <node TEXT="计算限速" ID="a8dadb4251ecd2b24c7a10739a31930d" STYLE="fork">
                          <node TEXT="限速 = min(130kph, 参考线的限速, 横向加速度的限速(1.5m/s2除以曲率), steer_angle_speed查表曲率变化率)" ID="f17278356d2a39073dd690e730e85ebc" STYLE="fork"/>
                        </node>
                        <node TEXT="overtake_bound = last_s + last_v * dt + 0.5* last_a * dt^2 + 1/6* current_jerk * dt^3" ID="5da2e09267aeefc38ea11c9c97b028a7" STYLE="fork"/>
                      </node>
                      <node TEXT="bnd_position = min(obs_max_s + obs_v, overtake_bound)" ID="d0b6e64c92e12ac39040e8aecfa17f34" STYLE="fork"/>
                      <node TEXT="thw = ttc = 0.0s" ID="f0c1d3a7f738136b9ed313fa707ff053" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="若为left nudge，则加入作为sl硬边界和sl软边界" ID="bd6280d4544a43c3006968dfe4e65c46" STYLE="fork">
                    <node TEXT="更新sl硬边界" ID="a75a6417319bec3f7c1a44d5ea355c80" STYLE="fork">
                      <node TEXT="更新sl硬边界的条件" ID="82e418dfdcc5c7ded403f931a901404b" STYLE="fork">
                        <node TEXT="静止obs" ID="98ed32b49ec1930ea3722c05c8f19979" STYLE="fork"/>
                        <node TEXT="dist_thresh = max(10m, 2.5s*ego_v)" ID="2bbaf6424b05beccb23edad700f012a7" STYLE="fork"/>
                        <node TEXT="obs_min_s - ego_s &gt; dist_thresh" ID="fb79226f4ad9a7791d9cf0e80edb17f5" STYLE="fork"/>
                        <node TEXT="ego_t_s - ego_s &gt; dist_thresh" ID="b34088bfda898f4da360397fea34bf21" STYLE="fork"/>
                        <node TEXT="t 小于 2.5s" ID="db1647f7d734f3dc61c71ab78f3376ad" STYLE="fork"/>
                        <node TEXT="obs_max_l + 0.3m &gt; lb" ID="451dbc093c2901f2b4f663d023c832c1" STYLE="fork"/>
                      </node>
                    </node>
                    <node TEXT="增加sl软边界" ID="a08c6d9a9ba70be8cae2d4d9a56dc05f" STYLE="fork">
                      <node TEXT="bnd_position = obs_max_l" ID="a871eeb6280613e280da25401010395d" STYLE="fork"/>
                      <node TEXT="nudge_buffer = 0" ID="235e2f9789d22ef7eb4556a99b4d74a1" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="若为right nudge，则加入作为sl硬边界和sl软边界" ID="61578bc037d371aaf3b1d60ae22e5e7b" STYLE="fork">
                    <node TEXT="更新sl硬边界" ID="180ab4cc78571f234a97da8b9bcd07dd" STYLE="fork">
                      <node TEXT="更新sl硬边界的条件" ID="621cc248e29741ec821f5dba8bd6356e" STYLE="fork">
                        <node TEXT="静止obs" ID="17bf513b417768b06472ca63cb15e0ea" STYLE="fork"/>
                        <node TEXT="dist_thresh = max(10m, 2.5s*ego_v)" ID="da0f2cde59c4ae35c36540e684b7a01a" STYLE="fork"/>
                        <node TEXT="obs_min_s - ego_s &gt; dist_thresh" ID="4d17e4045cc540afac6925efd83dff1f" STYLE="fork"/>
                        <node TEXT="ego_t_s - ego_s &gt; dist_thresh" ID="b3f10ba526090672f5e7ae4f6b24b0a6" STYLE="fork"/>
                        <node TEXT="t 小于 2.5s" ID="d10c0e817b32fccc211a290c108c8639" STYLE="fork"/>
                        <node TEXT="obs_min_l - 0.3m &gt; ub" ID="a2bb75d8c88aa92af9d83f275ea075b4" STYLE="fork"/>
                      </node>
                    </node>
                    <node TEXT="增加sl软边界" ID="d0b9799aa3b897a8b8c489b47192ea6b" STYLE="fork">
                      <node TEXT="bnd_position = obs_min_l" ID="5e9e35ccbb01c5b1cab5ed5221fa50d1" STYLE="fork"/>
                      <node TEXT="nudge_buffer = 0" ID="c441021809472a05d25a7063bc0760ec" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="若为ool left/right nudge，则加入作为sl软边界" ID="c7a661d00f9d6c930111c8cfecbda2f7" STYLE="fork">
                    <node TEXT="增加sl软边界" ID="5b0c0eab5161df78851001baeec9b6b0" STYLE="fork">
                      <node TEXT="增加软边界的条件" ID="33db0973ec39a187dfc1ef31885c7e9e" STYLE="fork">
                        <node TEXT="纵向有overlap" ID="965dc2ea76219a6e44c44af7b4d347ea" STYLE="fork">
                          <node TEXT="obs_max_s &gt; ego_t_s - 8m，且obs_min_s  &lt; ego_t_s + max(5m, 1.5s*ego_v)" ID="a5dc589b92f0abd6384ba398b2b6b029" STYLE="fork"/>
                        </node>
                      </node>
                      <node TEXT="bnd_position = obs_max_l" ID="9da3664ac0f0d61d57d99d682e893415" STYLE="fork"/>
                      <node TEXT="nudge_buffer = 0" ID="7f4119a5ea096cb109028b3deaf0857c" STYLE="fork"/>
                    </node>
                    <node TEXT="增加large weight sl软边界" ID="c0e8cf6534f4ff4873d6aaffa3ebbde5" STYLE="fork">
                      <node TEXT="增加large weight软边界的条件" ID="e4608b12a88f5d0d4ba7d8815d55faf0" STYLE="fork">
                        <node TEXT="纵向有overlap" ID="dd4c8e8e5db98eaa7095b4515e31ad0e" STYLE="fork">
                          <node TEXT="obs_max_s &gt; ego_t_s - clamp(0.15*ego_v, (1m, 3m))，且obs_min_s  &lt; ego_t_s + clamp(0.15*ego_v, (1m, 3m))" ID="85e3a66f1770359feb6639e044b8de56" STYLE="fork"/>
                        </node>
                      </node>
                    </node>
                  </node>
                  <node TEXT="若为cross yield，则加入作为st硬边界（若min_s小于ub）" ID="9a4b811faea8062b5b09286a3b80ed6b" STYLE="fork"/>
                  <node TEXT="若为risk，则加入作为st软边界" ID="d9aa9fab174126f9c033cac51cfd5475" STYLE="fork">
                    <node TEXT="bnd_position = obs_max_s" ID="65c0612a854bd37e1f9784f016af15e6" STYLE="fork"/>
                  </node>
                  <node TEXT="对st软边界的lb/ub进行排序" ID="27e749f726a9cb341b459c42dc6eb07e" STYLE="fork">
                    <node TEXT="lb的软边界，按obs_max_s倒排" ID="c40c4eaaf6725377d7472e653e29a29e" STYLE="fork"/>
                    <node TEXT="ub的软边界，按obs_min_s正排" ID="b1fd3f13d2ac7f22039eeb9e4c4710d9" STYLE="fork"/>
                  </node>
                </node>
              </node>
            </node>
            <node TEXT="构建环境的slt boundary" ID="a177a33034aab94a490bffd0b3d58686" STYLE="fork">
              <node TEXT="获取左右road edge上采样点（1m）的sl" ID="d0992cfd493c203cb69f11e3ef9c1aca" STYLE="fork">
                <node TEXT="将road edge按1m采样生成point，并transform（hd_t_dynamic_map）至hd" ID="44a092364a1e7edd8249cc26e5b1131b" STYLE="fork"/>
              </node>
              <node TEXT="构建sl boundary" ID="62d0e8549c0232ad366cf70560706a3b" STYLE="fork">
                <node TEXT="将纵向规划的path长度按180个点平均采样" ID="43cb9bb380403599126c5f129ed44ede" STYLE="fork">
                  <node TEXT="按road map的路肩/可跨越，实际变道或ool nudge状态，更新ub/lb硬边界和软边界" ID="6e77cde05fbc57817f9174cfb60d2f1f" STYLE="fork">
                    <node TEXT="更新ub硬边界和软边界" ID="83b0738dc089fed78b3c7d45aa3f078e" STYLE="fork">
                      <node TEXT="更新硬边界（若left_width小于ub）" ID="d76ddc26743e71050021248f09aa3e47" STYLE="fork">
                        <node TEXT="更新硬边界条件" ID="1100c19f4cf242c43558a4c81af44230" STYLE="fork">
                          <node TEXT="左车道为路肩" ID="a6a34156005a7bb7845ff2e9afe24b36" STYLE="fork"/>
                          <node TEXT="left boundary为physically not" ID="a1e92237c86962af11aff1292a4127f9" STYLE="fork"/>
                        </node>
                      </node>
                      <node TEXT="更新nudge软边界" ID="a6ffd616f591cc8340f163ce61aecd62" STYLE="fork">
                        <node TEXT="更新nudge软边界条件" ID="4cbf136b3b573509f5d0378c063c7766" STYLE="fork">
                          <node TEXT="左车道为路肩" ID="1033c6c8b0176f2f3f621337b13f561c" STYLE="fork"/>
                          <node TEXT="left boundary为physically not或legally not" ID="1d235a6f4cf94f1778d5693e0e19c01c" STYLE="fork"/>
                        </node>
                        <node TEXT="bnd_position = max(left_width - 0.5m, 0.5自车宽度）" ID="9c2a2d92fcc2d14ab3dbaca39ae1ccce" STYLE="fork"/>
                        <node TEXT="nudge_buffer = 0.5m" ID="eb9f95b5bd73e77769a9293369498c39" STYLE="fork"/>
                      </node>
                      <node TEXT="更新cross软边界" ID="6c66689f75d74bba61d03a5d5cfffe5f" STYLE="fork">
                        <node TEXT="更新cross软边界条件" ID="f70dca5131ba1632fae65540b020702e" STYLE="fork">
                          <node TEXT="当前不在ool nudge且变道状态" ID="1d35136874fae245191fce5b2877f185" STYLE="fork"/>
                        </node>
                        <node TEXT="bnd_position = left_width" ID="c1bac2181edb6d5af9a613fb86c5238c" STYLE="fork"/>
                        <node TEXT="nudge_buffer = 0.5m" ID="4f095cb9870a9cb459c54c770994d641" STYLE="fork"/>
                      </node>
                    </node>
                    <node TEXT="更新lb硬边界和软边界" ID="bf65f91ebc8984a5d4e4bf8d815129cb" STYLE="fork"/>
                  </node>
                  <node TEXT="按road edge更新nudge软边界" ID="234c282920dea6fb3175032cd57c06f8" STYLE="fork">
                    <node TEXT="ub软边界 = max(left_l - 0.7m, -min(3m, right_width) + 0.2m + 0.5自车宽度）" ID="4a3712180cce96f1ada8eb2182c2526d" STYLE="fork"/>
                    <node TEXT="lb软边界 = min(right_l + 0.7m, min(3m, left_width) - 0.2m - 0.5自车宽度）" ID="deebd626e69c95a50611975ba3aeedb7" STYLE="fork"/>
                  </node>
                  <node TEXT="将road map的路肩的nudge软边界和road edge的nudge软边界合并（ub取小，lb取大）" ID="6c83f0f209c88b9900095d25bd071651" STYLE="fork"/>
                  <node TEXT="更新obs的nudge软边界" ID="e18f9cfc3b401ae4a54decfaf7bb1bf0" STYLE="fork">
                    <node TEXT="获取obs nudge的最小的lb的软边界" ID="74497eadf3f77bd99cfdc21ae24ace11" STYLE="fork"/>
                    <node TEXT="更新lb" ID="0566dfa18e8efeaa1f9d08e02d1c3a86" STYLE="fork">
                      <node TEXT="计算横向安全距离" ID="ee5f6628a5f7451d86d93495cb632c22" STYLE="fork">
                        <node TEXT="若为向左/右变道，则safe_lat_distance = 0.6m" ID="66092c822a8ab1847b8a77ee2d2b22f1" STYLE="fork"/>
                        <node TEXT="其他" ID="e719bb98990a2cacaa51ad6d942896a1" STYLE="fork">
                          <node TEXT="safe_lat_distance1" ID="e08ca0c51c8aab95a0d41c33da3a1ddb" STYLE="fork">
                            <node TEXT="若为car" ID="3e2a83a385e07a023d387b26cb345c6e" STYLE="fork">
                              <node TEXT="低速（20kph）安全距离：0m" ID="b3c65d48a6dd342589db9fbe68c9365e" STYLE="fork"/>
                              <node TEXT="高速（60kph）安全距离：0.1m" ID="718adeb8e57d88432b48ca7e09100dcb" STYLE="fork"/>
                            </node>
                            <node TEXT="其他" ID="a7b2369eef478e9e1ca23be09881533e" STYLE="fork">
                              <node TEXT="低速（20kph）安全距离：0.0m" ID="6dafba3dfee2ac04385708ffcdb0958a" STYLE="fork"/>
                              <node TEXT="高速（60kph）安全距离：0.5m" ID="90c754f860895d3319ca992b708cd810" STYLE="fork"/>
                            </node>
                            <node TEXT="根据ego_v插值" ID="faf9536c66fa708b7d7c742f041f68cc" STYLE="fork"/>
                          </node>
                          <node TEXT="safe_lat_distance2" ID="0740c64542bc1d5693b755db7495e5e4" STYLE="fork">
                            <node TEXT="低速（20kph）安全距离：0.5m" ID="3267751249e62d62ebf36e1917fe2ea4" STYLE="fork"/>
                            <node TEXT="高速（60kph）安全距离：1.6m" ID="38d9b16b8335f28217510581e902b1f3" STYLE="fork"/>
                            <node TEXT="根据ego_v插值" ID="1f83b7c661c36149be508e3f68d576ba" STYLE="fork"/>
                          </node>
                          <node TEXT="safe_lat_distance = max(min(0.5车道宽度+safe_lat_distance1-0.5自车宽度, safe_lat_distance2), 0.5m)" ID="f16c6da077680e7db2ab26a85a4d7a65" STYLE="fork"/>
                        </node>
                      </node>
                      <node TEXT="lb = lb + safe_lat_distance + 0.5自车宽度，分为四档[0, 0.25m, 0.35m, 0.5m]" ID="7ad0ec8343c1b81e682ef2a2b5d4e232" STYLE="fork"/>
                      <node TEXT="取最大的lb作为软边界" ID="deb7bb27d8101e45036c163c9a0d35c2" STYLE="fork"/>
                    </node>
                    <node TEXT="更新ub" ID="243da4a1e1e1330214c65becaa6de455" STYLE="fork">
                      <node TEXT="计算横向安全距离" ID="1333a0ea5e400682c79d3d3f02b85410" STYLE="fork"/>
                      <node TEXT="ub = ub - safe_lat_distance - 0.5自车宽度，分为四档[0, -0.25m, -0.35m, -0.5m]" ID="ca7fa24f0e929c809b34fa142ee1ec15" STYLE="fork"/>
                      <node TEXT="取最小的ub作为软边界" ID="ce32130701f2763b9175e8bbe47af8a1" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="更新obs的ool nudge软边界" ID="3b39a5bf3d42c23f8da057818bafa225" STYLE="fork">
                    <node TEXT="safe_lat_distance = 0.8m" ID="919226bed591a22b08fd718f58aec543" STYLE="fork"/>
                    <node TEXT="更新lb" ID="f18ecad276011337380f8bf19bdcb9a5" STYLE="fork">
                      <node TEXT="lb = lb + safe_lat_distance" ID="2868af296e6200ddbd69662a80e0ec68" STYLE="fork"/>
                      <node TEXT="取最大的lb作为软边界" ID="3df1b0211612c59c1760adc68d5dcf19" STYLE="fork"/>
                    </node>
                    <node TEXT="更新ub" ID="5560ddcc8d688a4b867ab478550d5ba0" STYLE="fork">
                      <node TEXT="ub = ub - safe_lat_distance" ID="492d074c29d47a6ffdd52d1df07482d8" STYLE="fork"/>
                      <node TEXT="取最小的ub作为软边界" ID="700b8a22aae69f69cbaf70af0f5257e3" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="更新obs的large weight ool nudge软边界" ID="d6e59ec42d1eaf42495faeeee7238e12" STYLE="fork">
                    <node TEXT="safe_lat_distance = 0.3m" ID="479ba90f6f978512e19b303267055c7c" STYLE="fork"/>
                    <node TEXT="更新lb" ID="fc372ca21097614179b25cbd8f1afad7" STYLE="fork">
                      <node TEXT="lb = lb + safe_lat_distance" ID="bc0928039f380470bcbfe58b5c89c2cf" STYLE="fork"/>
                      <node TEXT="取最大的lb作为软边界" ID="c5677950d82f07675271b97752e52267" STYLE="fork"/>
                    </node>
                    <node TEXT="更新ub" ID="77bf4de8bf43cefbb56a78fa702a75db" STYLE="fork">
                      <node TEXT="ub = ub + safe_lat_distance" ID="3a033eb8d39f1edc2c1b84ea65453d3e" STYLE="fork"/>
                      <node TEXT="取最小的ub作为软边界" ID="0f36d8891b74534ea05ca02278be28cc" STYLE="fork"/>
                    </node>
                  </node>
                  <node TEXT="调整所有的lb/ub软边界" ID="01a1777da46dd60200d847ae88efa6ae" STYLE="fork">
                    <node TEXT="lb += 0.5自车宽度" ID="1ddbeaff82f58afe9e202abd6a285d2e" STYLE="fork"/>
                    <node TEXT="ub -= 0.5自车宽度" ID="f2208e1ef0539f01fe0676119ecdff83" STYLE="fork"/>
                  </node>
                  <node TEXT="check可通过性" ID="69b0730ac18cccb454434ef6b14f688a" STYLE="fork">
                    <node TEXT="lb + 0.2m &gt; ub，则修正lb, ub" ID="362f5375b654aadef4353c492aff2350" STYLE="fork"/>
                  </node>
                </node>
              </node>
              <node TEXT="构建st boundary" ID="1dd8c6ca643f5ee10f0238296983b73f" STYLE="fork">
                <node TEXT="采样间隔为0.2s" ID="d60466df5ee84fc820283565e15c98a5" STYLE="fork"/>
                <node TEXT="对yield的软边界合并，取最小bnd_position" ID="a95d779eae36b5c4da571d5d0d1f9e1a" STYLE="fork"/>
                <node TEXT="对slot yield的软边界合并，取最小bnd_position" ID="84a1317cf254fed61b6b6abc7032a55a" STYLE="fork"/>
                <node TEXT="对merge yield的软边界合并，取最小bnd_position" ID="dd08ce0c9da1431dd04a4b50ac9b6c81" STYLE="fork"/>
                <node TEXT="对merge overtake的软边界合并，取最大bnd_position" ID="8c38eb4347eeb352e36600821ae18c21" STYLE="fork"/>
                <node TEXT="对slot not yield的软边界合并，取最大bnd_position" ID="409b259abdb22d1d2495faceea5632d3" STYLE="fork"/>
                <node TEXT="对align yield的软边界合并，取最小bnd_position" ID="17e945804eceb0f9f86eb832735afe1f" STYLE="fork"/>
                <node TEXT="加入所有的risk的软边界" ID="46312e7581504b4879a2bfcd09d1bfd4" STYLE="fork"/>
              </node>
            </node>
          </node>
          <node TEXT="Piecewise Jerk Path Optimizer" ID="f3b36d260852a0a1c75228b848fdbebe" STYLE="fork">
            <node TEXT="加入sl point的硬约束" ID="eee33bea582813249b5d2638d92e151b" STYLE="fork"/>
            <node TEXT="生成可跨越车道线的约束（最大lb, 最小ub）" ID="1959d9ebe8c34dddbc77523f0ab3782d" STYLE="fork">
              <node TEXT="weight为3" ID="0d3fd0ac2820ba269e684bf9b2360ccf" STYLE="fork"/>
            </node>
            <node TEXT="生成nudge的约束" ID="1192cbccc8a43348ac694a275f9116be" STYLE="fork">
              <node TEXT="合并obs, shoulder, boundary nudge的lb和ub" ID="30ae4977ee8692ca4256ae65396ac2d3" STYLE="fork"/>
              <node TEXT="weight为100 " ID="68fb9214eccfc2bfa2480cbdc6696905" STYLE="fork"/>
            </node>
            <node TEXT="生成ool nudge的约束" ID="5e4503cfa99eaf16fb14ddbe1bf2c1fa" STYLE="fork">
              <node TEXT="weight为50" ID="e402af3015df777dbe4db79df041736d" STYLE="fork"/>
            </node>
            <node TEXT="生成ool nudge large weight的约束" ID="d9f021ff22e8763222a50800589cb4a0" STYLE="fork">
              <node TEXT="weight为20000" ID="66c385f7b348e1082dfe076ce57a8bb2" STYLE="fork"/>
            </node>
          </node>
          <node TEXT="Piecewise Jerk Speed Optimizer" ID="a8bcfbd4a69a5d5f15bdb3f9a77fa512" STYLE="fork">
            <node TEXT="生成参考线" ID="8a06adee6788db8524189076da0fa7ec" STYLE="fork">
              <node TEXT="按照0.2s采样" ID="373d6d3af21263dd3c2812b547bb6166" STYLE="fork">
                <node TEXT="计算曲率限速" ID="21622977b348afc692e38ba052ab7836" STYLE="fork">
                  <node TEXT="获取弯道限速" ID="0b83ad17e5e73487518f00c1920b25f3" STYLE="fork">
                    <node TEXT="按横向acc1.5m/s2生成曲率限速" ID="30262589d989b790422a32226d2f760e" STYLE="fork"/>
                  </node>
                  <node TEXT="计算yawrate变化率限速" ID="38068edb9e085b147042b16499e08f34" STYLE="fork"/>
                  <node TEXT="根据曲率和曲率变化率查steer_angle_speed_table获取方向盘转角限速" ID="61057ae60b4419aff6aba659ecfde284" STYLE="fork"/>
                  <node TEXT="根据曲率和曲率变化率查steer_angle_speed_table获取横向Jerk限速" ID="35a1ccaeb6518965e9e0629ffba94b65" STYLE="fork"/>
                  <node TEXT="限速=min(上述四个)" ID="9e5107c1f4bd857aa67fcedd1efd5f08" STYLE="fork"/>
                </node>
                <node TEXT="计算地图限速" ID="5f82c3fb8eefad9325e0125bbee1a42f" STYLE="fork">
                  <node TEXT="参考限速" ID="be66fb922e3dfaa6192254c8086a8e6c" STYLE="fork">
                    <node TEXT="下匝道限速" ID="dfe037159b680bc192e83a153106d4e8" STYLE="fork"/>
                    <node TEXT="服务区限速" ID="38b3c88ffba170f24aeb9fd90912e783" STYLE="fork"/>
                    <node TEXT="和服务区有overlap的限速" ID="9ff9e9b6793a0bbb4010539c5d4f7602" STYLE="fork"/>
                  </node>
                  <node TEXT="限速=min(参考限速, 地图限速)" ID="ecc8c9ffa16bf69d4ccd60082639b460" STYLE="fork"/>
                </node>
                <node TEXT="舒适加速度（跟起3.0m/s2，其他1.5m/s2）" ID="9e03900b58317d734119f1a7a08c7eb0" STYLE="fork"/>
                <node TEXT="舒适Jerk（跟起4.0m/s3，其他2.0m/s3）" ID="63d94c9c2e3ab273839ecdb6b0d07f7c" STYLE="fork"/>
                <node TEXT="计算轨迹" ID="00d87cb7686e48156575b121b1ccd48c" STYLE="fork">
                  <node TEXT="参考轨迹" ID="4e731583a55613207f12d5cbf935d6ad" STYLE="fork">
                    <node TEXT="按舒适加速度，舒适Jerk按采样时间积分轨迹的s和comfort_acc_v" ID="b5e5460c27fb93baf93274e36d12751c" STYLE="fork"/>
                    <node TEXT="按舒适减速度（-0.8m/s2），舒适减速Jerk（-1.0m/s3）按采样时间积分轨迹的s和comfort_dec_v" ID="8487a124844561b5bf202d6d9f0913aa" STYLE="fork"/>
                    <node TEXT="最大舒适减速度（-1.8m/s2）按采样时间积分轨迹的s和steep_dec_v" ID="b8e18f244fc3baf1ac21758a96f05172" STYLE="fork"/>
                    <node TEXT="slow down减速度（-0.5m/s2），减速Jerk（-1.5m/s3）按采样时间积分轨迹的s和slow_down_v" ID="ca9a7d46f2be56e3ca2ee4e7ef7d76ea" STYLE="fork"/>
                    <node TEXT="用户最大舒适减速度（-1.0m/s2）按采样时间积分轨迹的s和user_dec_v" ID="38d1164b68135d0fdb811071d4e8658a" STYLE="fork"/>
                  </node>
                  <node TEXT="参考速度" ID="a7f70695d5aafa22f1219b6017c85514" STYLE="fork">
                    <node TEXT="min(max(min(曲率限速，comfort_acc_v), steep_dec_v), ego_v + 8.0m/s)" ID="fbd43848670af415e97e3ef4da671296" STYLE="fork"/>
                  </node>
                  <node TEXT="限速" ID="aac80deca2883ce4065591149f673eb4" STYLE="fork">
                    <node TEXT="min(曲率限速, 地图限速)" ID="dfb56dfb0e93ad3c4a73468a8585b5f6" STYLE="fork"/>
                  </node>
                  <node TEXT="参考s" ID="83a4bea0c4f00dc2e2676b38437eea07" STYLE="fork">
                    <node TEXT="根据当前车速和​规划控制方案对比​中的标定表插值得到ref_a和ref_jerk，进而算出ref_s" ID="6390b7ec985e2b6fa37b23e14ac272a2" STYLE="fork"/>
                  </node>
                </node>
              </node>
            </node>
            <node TEXT="遍历st boundary" ID="2e6b8d5353bfbbde45529c4f09189e1f" STYLE="fork">
              <node TEXT="计算obs的tau gap" ID="c15700ff36695f402be8ecd451fc83bf" STYLE="fork">
                <node TEXT="变道统一按0.7s" ID="133c5083a4c1571aea460a6b3b9ddad6" STYLE="fork"/>
                <node TEXT="非变道" ID="4b2b0bba22b53a78f90a004bbbaca84a" STYLE="fork">
                  <node TEXT="estimate_tau_gap = (bnd_position - ego_v * 0.2s) / ego_v" ID="c0d202408efad94cb17f2636bbfd3133" STYLE="fork"/>
                  <node TEXT="tau_gap_ttc = (bnd_position - ego_v * 0.2s - 1s * (ego_v - obs_v)) / ego_v" ID="b97905ed990416043dc0564c6ef091d1" STYLE="fork"/>
                  <node TEXT="delta_tau" ID="5ebad57bd05d2616efb764131885f996" STYLE="fork">
                    <node TEXT="低速（5m/s）min_delta_tau：0.28s" ID="49d83de7cea19320473b23523ce79c3b" STYLE="fork"/>
                    <node TEXT="高速（30m/s）max_delta_tau：0.3s" ID="9e1b2d47560dcc44ee744a411b613207" STYLE="fork"/>
                    <node TEXT="根据ego_v插值" ID="aa4670c8476a46dcf56ff48c98ded5d0" STYLE="fork"/>
                  </node>
                  <node TEXT="target_tau = clamp(min(estimate_tau_gap, tau_gap_ttc) + delta_tau, 1.0s, user_tau_gap)" ID="f60ea1d8496b930bd65d39bc9041e9f0" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="细化低速（小于5m/s）下的thw" ID="3dec2ea83b6265f4c46c611e931b5d71" STYLE="fork">
                <node TEXT="蠕行速度（2m/s）thw：0.5s" ID="8c2d311201d321380cabcade64ed7752" STYLE="fork"/>
                <node TEXT="中速（5m/s）thw：1s" ID="3fd9fef66202f5b18c6dde8eb8e672ba" STYLE="fork"/>
                <node TEXT="根据ego_v插值" ID="874d51e9f476d4d7103a73f474262a4b" STYLE="fork"/>
              </node>
              <node TEXT="生成跟车的约束" ID="5de056d0ef433d6f695e67f3fb81f187" STYLE="fork">
                <node TEXT="expect_ttc" ID="775084ebeb9b5b6f87fe1c3cfeb64107" STYLE="fork">
                  <node TEXT="若ego_v小于obs_v" ID="238fc97871fa4b2e2bcdb11900ecc3c2" STYLE="fork">
                    <node TEXT="expect_ttc = 2.0*e^((obs_v-ego_v)/33.333m/s) + 2.0s" ID="1648ee98f12385eecde46d8a7d864d91" STYLE="fork"/>
                  </node>
                  <node TEXT="否则，不在变道中" ID="157ddc3ce6ff8d12ea5623c6a056bed4" STYLE="fork">
                    <node TEXT="前车距离（2.0m）ttc_ratio：1.0" ID="9d65bb958e2bfd16bc425379500d885c" STYLE="fork"/>
                    <node TEXT="前车距离（6.0m）ttc_ratio：1.5" ID="81dd04bc7d8e02ed7ed72055fd731297" STYLE="fork"/>
                    <node TEXT="前车距离（7.0m）ttc_ratio：1.5" ID="dfbb0b220999f94bce08a12d42c063da" STYLE="fork"/>
                    <node TEXT="根据前车距离插值得到ttc_ratio，expect_ttc = 2.0s*ttc_ratio" ID="a68aaaf940b0359bf16f9d3e340a7285" STYLE="fork"/>
                    <node TEXT="低速（3m/s）进一步调整ttc_ratio及其expect_ttc" ID="eeda10d9cefc2da5103265ff7cb9b4c2" STYLE="fork"/>
                  </node>
                </node>
                <node TEXT="expect_thw_ratio = 1-e^(2*min(0.0, d_v)) * (min(obs_l, 1.0) - 0.5) / 0.5" ID="9a7214cc46446f198b935fa9693e6e88" STYLE="fork"/>
                <node TEXT="expect_thw = expect_thw_ratio * obs_tau_gap" ID="16779b1ddcf2c635d56c56109e639fc7" STYLE="fork"/>
                <node TEXT="约束" ID="765e52fc5d3548ef0e5ea6b0147b7534" STYLE="fork">
                  <node TEXT="x = 1.0" ID="faa1ed9beeb8f13116204768e3127bd8" STYLE="fork"/>
                  <node TEXT="dx = expect_ttc + expect_thw" ID="0de22e95d7fb32053868faaa79ae0873" STYLE="fork"/>
                  <node TEXT="ddx = 0" ID="cd6704c6af3dd128781c6864ee2d27f1" STYLE="fork"/>
                  <node TEXT="epsilon = 1.0" ID="0d240c6026bb00cdadf0f26423e21856" STYLE="fork"/>
                  <node TEXT="lb = 0" ID="b726f3e292b1b815976c9904469f6e0e" STYLE="fork"/>
                  <node TEXT="ub = obs_s - 1m - expect_ttc * obs_v" ID="9a6f54aac9178c0ebaa976c814461989" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="生成merge yield的约束" ID="b7025d37624fd375ff3b0076d8180317" STYLE="fork"/>
              <node TEXT="生成slot yield的约束" ID="0045cb5ae9af50cf1eccda354b98b919" STYLE="fork">
                <node TEXT="若ego_v小于obs_v" ID="cb5291a70c1dd58f2eed4d855f3a3868" STYLE="fork">
                  <node TEXT="expect_ttc = 2.0*e^((obs_v-ego_v)/33.333m/s) + 2.0s" ID="855951ba6140f01f8a6210661c6e4a2a" STYLE="fork"/>
                  <node TEXT="expect_thw = obs_tau_gap" ID="096ceb8175a1bef7e01bfc40da6e1715" STYLE="fork"/>
                </node>
                <node TEXT="约束" ID="a904e4dc6e42ea82870a048915f57122" STYLE="fork">
                  <node TEXT="x = 1.0" ID="8f924d5ee1b1f8b7073fcded4d4e2afd" STYLE="fork"/>
                  <node TEXT="dx = expect_ttc + expect_thw" ID="a5bf2b0106a6da4fab507d218e8ac533" STYLE="fork"/>
                  <node TEXT="ddx = 0" ID="68a5c649b149e47f453418a91d46b24b" STYLE="fork"/>
                  <node TEXT="epsilon = 1.0" ID="8434f102aeda2f040821765b44db2115" STYLE="fork"/>
                  <node TEXT="lb = 0" ID="b1fdbfcda95362efa65cf685619b565c" STYLE="fork"/>
                  <node TEXT="ub = obs_s + expect_ttc * obs_v" ID="34a7748c8ba94c9a0b7abc7852287472" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="生成slot not yield的约束" ID="07984ad69b0f3893b48d4f037cae0359" STYLE="fork">
                <node TEXT="ttc = 3s" ID="e2665a727f8f17e186d5c017830daaec" STYLE="fork"/>
                <node TEXT="thw = 1s" ID="98a335ef5843006f41973d19c6f56b77" STYLE="fork"/>
                <node TEXT="约束" ID="4cb6a7069e34bd6fce0caeb8e108ffbc" STYLE="fork">
                  <node TEXT="x = 1.0" ID="ab58cf9f706773aeba79e588bf6c9fd1" STYLE="fork"/>
                  <node TEXT="dx = ttc" ID="53836e02f3c5f7e57951100285feeca8" STYLE="fork"/>
                  <node TEXT="ddx = 0" ID="e4a52c697ca85ee33b82e1576d63de8e" STYLE="fork"/>
                  <node TEXT="epsilon = -1.0" ID="9b748a7ae32b30bac5fbf5d565769060" STYLE="fork"/>
                  <node TEXT="lb = (ttc+thw)*obs_v + obs_s" ID="0714875525a12e371786e950276daa4e" STYLE="fork"/>
                  <node TEXT="ub = 0" ID="3e8f51bf3de1e4a7d750112f9b55237b" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="生成merge overtake的约束" ID="7f65576f4dbb7c0cbd6459e283f9c1d3" STYLE="fork">
                <node TEXT="约束" ID="55e5edddf6e860fff054a8bf6c242974" STYLE="fork">
                  <node TEXT="x = 1.0" ID="311f82c417bc7250d8640d909d5fda93" STYLE="fork"/>
                  <node TEXT="dx = 0" ID="5f679dc381b27e9a3acb5a3d1bc7d8a2" STYLE="fork"/>
                  <node TEXT="ddx = 0" ID="39eaec70e0ef858fbdb8ea74cf4ee51e" STYLE="fork"/>
                  <node TEXT="epsilon = -1.0" ID="0b10232acca2d6a476718cfbec309e4a" STYLE="fork"/>
                  <node TEXT="lb = obs_s" ID="e08a2184b5b30b37aa9beb2ccb2c6164" STYLE="fork"/>
                  <node TEXT="ub = 0" ID="77a006f08438824ffb384959caa81007" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="生成align yield和align not yield的约束" ID="36f8701c116f60857f154f6a313e28a6" STYLE="fork">
                <node TEXT="找到最近的front（align yield）和back（align not yield）的软约束，若front或back无效，则分别为double_max和double_min" ID="78785c7b8a7c2e9f443b1d1d5279be62" STYLE="fork"/>
                <node TEXT="s约束" ID="2568918f12109d3e18d9255851d445d0" STYLE="fork">
                  <node TEXT="x = 1.0" ID="eeffe97c9b752a296b7e05b9e730e1b4" STYLE="fork"/>
                  <node TEXT="dx = 0" ID="5a4af52b98cf045d7d15d53acc091a2c" STYLE="fork"/>
                  <node TEXT="ddx = 0" ID="63451720b0915328b830f09a9d187ac4" STYLE="fork"/>
                  <node TEXT="epsilon = 1.0" ID="01574f0716725b08bc6f2d1862e74315" STYLE="fork"/>
                  <node TEXT="lb = back_s" ID="174db90927b249e836dffa66e5215f3b" STYLE="fork"/>
                  <node TEXT="ub = front_s" ID="e120fd031ba2233e51d3214745eda05d" STYLE="fork"/>
                </node>
                <node TEXT="v约束" ID="e4116d976fcf4a6fef7cbf078264c5ed" STYLE="fork">
                  <node TEXT="x = 0" ID="ba14e114fb444310eacd6091407ff302" STYLE="fork"/>
                  <node TEXT="dx = 1.0" ID="0a939de1540acb1c6787af52d75ad87b" STYLE="fork"/>
                  <node TEXT="ddx = 0" ID="69091ec1cf3ff77f79b7ee1473b00aeb" STYLE="fork"/>
                  <node TEXT="epsilon = 1.0" ID="ed885159a1b49ad6b599cb48a5cb7e43" STYLE="fork"/>
                  <node TEXT="lb = back_v" ID="46cacb3afcb2e5e7a826cc2a2e3709fb" STYLE="fork"/>
                  <node TEXT="ub = front_v" ID="cc6a24a17fad84670b934ff059fcbce4" STYLE="fork"/>
                </node>
              </node>
              <node TEXT="生成nudge的约束" ID="04ec9f230644b2934c833a0aa491689f" STYLE="fork">
                <node TEXT="约束" ID="d48645dd1f383dc7b16581ef33d765ee" STYLE="fork">
                  <node TEXT="x = 0" ID="ef85a4c9ada0c16b61cb105bcc1fc570" STYLE="fork"/>
                  <node TEXT="dx = 1" ID="8ec773c7b4a4ba1fc32a40967653c5ef" STYLE="fork"/>
                  <node TEXT="ddx = 0" ID="d5793f12e7eb8ba41a44462f9807c725" STYLE="fork"/>
                  <node TEXT="epsilon = 1.0" ID="7a400b024583f3a8fc4182063a9eee9c" STYLE="fork"/>
                  <node TEXT="lb = 0" ID="76560282fc4899aebf6b30109538a99b" STYLE="fork"/>
                  <node TEXT="ub = max(obs_v + 5m/s, ego_v - bnd_t)" ID="c1471ce70ffd204a1476141b38316918" STYLE="fork"/>
                </node>
              </node>
            </node>
          </node>
        </node>
      </node>
    </node>
    <node TEXT="50ms的定时器处理" ID="290e18f20773269486b671eed51de091" STYLE="bubble" POSITION="right">
      <node TEXT="ODD的虚拟边界" ID="838763fdc4f53bf12c96170829967d22" STYLE="fork">
        <node TEXT="主路：250m" ID="ce946edcb8ff40770559e69a2540d161" STYLE="fork"/>
        <node TEXT="匝道：60m" ID="fa02ae7fd03153559403544f11d4e821" STYLE="fork"/>
      </node>
      <node TEXT="初次加载" ID="2a330658054c28725967220704fa8bcb" STYLE="fork">
        <node TEXT="根据variant code（EU/CN）更新fct配置信息" ID="712e30eece723455e2cc954adfa827cf" STYLE="fork"/>
      </node>
      <node TEXT="更新诊断信息" ID="dfa872f5ee05a21d257b724a2c36a20e" STYLE="fork">
        <node TEXT="更新topic状态信息" ID="f8e6c4189e89aee1fe82cd3bfa06edc2" STYLE="fork"/>
        <node TEXT="更新FIM信息" ID="6439cd31899d62188cfc154251fb2fd5" STYLE="fork"/>
        <node TEXT="处理FailSafe，更新功能的故障状态" ID="f6cdb25c041f9d1a6fef9758d39657d1" STYLE="fork"/>
      </node>
      <node TEXT="更新状态机信息" ID="06137581a7036f0172e1c2dbd4ec291c" STYLE="fork">
        <node TEXT="更新用户ALC确认模式" ID="b9596e536694d3bba7271d22cdee96a0" STYLE="fork"/>
        <node TEXT="更新ALC变道状态" ID="27f91ae9482d14f7c055aceed3fec4c3" STYLE="fork"/>
        <node TEXT="更新点亮转向灯请求" ID="8740c3c37ffcfd1bf300240a78a1e18a" STYLE="fork">
          <node TEXT="用户重拨/轻拨转向灯拨杆（LEFT/RIGHT）" ID="06dfe5e56abbe897cfcefe831560ee44" STYLE="fork"/>
          <node TEXT="需要触发打转向灯" ID="1a40eadf48a1c6a5d4c055d81a03c9c3" STYLE="fork">
            <node TEXT="下匝道，即将进入匝道（distance &gt; 0）" ID="2d7b352955adf363048bde3ec735040e" STYLE="fork"/>
            <node TEXT="连续变道（变道&gt;=2），distance &lt;= 700m" ID="6008dcf10002e75fe1a4bcaadc02b21e" STYLE="fork"/>
            <node TEXT="变一次道，distance &lt;= 500m" ID="0b14240d1070348a4225cad51ceb39a8" STYLE="fork"/>
          </node>
          <node TEXT="点亮转向灯" ID="020898bc8e6a0ddc887e0eeee15c7204" STYLE="fork">
            <node TEXT="ALC状态为PREPARE_LEFT_LANE_CHANGE/PREPARE_RIGHT_LANE_CHANGE" ID="9caca49db3e764c311b8c23cca4fca77" STYLE="fork">
              <node TEXT="用户触发" ID="ef1a4465ea924d5e13f1dea959d09303" STYLE="fork"/>
              <node TEXT="无需确认 且" ID="82d1c2ace2f9bdcda671e6bb90a25427" STYLE="fork">
                <node TEXT="merge且无法拒绝 或 下匝道 或 分流" ID="dc969c117917dfa85e549b677fc09bf4" STYLE="fork"/>
              </node>
            </node>
            <node TEXT="ALC状态为EXCUTING_LEFT_LANE_CHANGE/EXCUTING_RIGHT_LANE_CHANGE" ID="fd1423829d7832c6357ae122a7abd37a" STYLE="fork"/>
          </node>
          <node TEXT="不打或取消转向灯点亮" ID="7f98da4add82e6143aced1f2c43cc979" STYLE="fork">
            <node TEXT="ALC状态为ABORTING_LANE_CHANGE_INTO_NEW_LANE/LANE_CENTERING" ID="3db2ab6c254ec9e6f02f44bf8d51ec97" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="更新NOP+ WTI" ID="d3d0dc653bc04867c9f0699f0277e886" STYLE="fork">
          <node TEXT="ALC的WTI" ID="bc52c9f56253a01bc3cfcc916e547ed4" STYLE="fork"/>
          <node TEXT="Operation Event Domain的WTI" ID="dba7b537c567f193d762348c89adb9f5" STYLE="fork">
            <node TEXT="距离LaneSeg事件距离&lt;1km，持续3s" ID="a9e1b2e73031ccddbf0f590ce1163bb2" STYLE="fork"/>
            <node TEXT="距离LaneSeg事件距离&lt;300m，持续3s" ID="56b2b1689625c4a72eb74508f1a54be2" STYLE="fork"/>
            <node TEXT="距离LaneSeg事件距离&lt;150m，持续5s" ID="1670ca594896f0be80f79f0ea7fc5082" STYLE="fork"/>
          </node>
          <node TEXT="ODD的WTI" ID="592d0cd638afa43392b27e70d278e75c" STYLE="fork">
            <node TEXT="Highway" ID="7d9d603287a12da408cab7300ac3b2f8" STYLE="fork">
              <node TEXT="在主路上，距离ODD边界距离&lt;400m" ID="76359092f712d8e8ffbeafd64fb6529b" STYLE="fork"/>
              <node TEXT="非主路上，距离ODD边界距离&lt;150m" ID="e77e90b08bb2283f9913c71ac8744d18" STYLE="fork"/>
              <node TEXT="距离ODD边界距离&lt; 1m + ODD的虚拟边界" ID="b4b52999fe6b3b265e8e921fadebc3c2" STYLE="fork"/>
            </node>
            <node TEXT="Urban" ID="58b48ead0e18bd068550a0fc6cfa5b9b" STYLE="fork">
              <node TEXT="在主路上，距离ODD边界距离&lt;500m" ID="a976df5a20d587a85faa5625358d8355" STYLE="fork"/>
              <node TEXT="距离ODD边界距离&lt; 1m + ODD的虚拟边界" ID="a357ae748b3345001f31d66bb978fe35" STYLE="fork"/>
            </node>
            <node TEXT="全局路由" ID="e46b8caec75fde5d4525c60a2bb60c2e" STYLE="fork">
              <node TEXT="距离终点距离&lt; 1m + ODD的虚拟边界" ID="63d161e77e9f1018468d89b8b25c2cab" STYLE="fork"/>
            </node>
            <node TEXT="下匝道" ID="34360de627f8a37c60f263501e93001e" STYLE="fork">
              <node TEXT="距离split点的距离&lt; 200m" ID="b14cc0c11d0a6d4bbd310907ee357ff4" STYLE="fork"/>
              <node TEXT="距离split点的距离&lt; 150m" ID="6136ff52b4c4f0b642db2c32e8c42ecb" STYLE="fork"/>
            </node>
          </node>
          <node TEXT="施工区域的WTI" ID="aadf05abbdae8752c8e5efc4e535cf93" STYLE="fork">
            <node TEXT="WTI的条件" ID="ddc7cbfe597d70d5e44d40009fedc1ff" STYLE="fork">
              <node TEXT="单侧（LEFT/RIGHT车道+左右车道线上）的锥桶数目&gt;3" ID="79ab88e0ff779b9fe8b88991441f5c1e" STYLE="fork"/>
              <node TEXT="自车车速&gt;20kph" ID="c783f260a758c0b55935ff3389dbac78" STYLE="fork"/>
              <node TEXT="施工区域的冷却时间&gt;120s" ID="1e55d6ec6f89c3f4e84cb494c330e756" STYLE="fork"/>
              <node TEXT="无高优激活的WTI" ID="05df6fea2e87804670e7b44f6655629a" STYLE="fork"/>
            </node>
          </node>
          <node TEXT="NOP+ Cutin的WTI" ID="6769acf51349de80b12bb91e4ff47124" STYLE="fork">
            <node TEXT="BP的yield对象 &amp; 同时在obstacle risk中" ID="3bc9a6d6c8f3137863488017f5b63fc4" STYLE="fork"/>
            <node TEXT="cutin obstacle risk目标" ID="7769d1e7d22a40385e0c107f9d701d69" STYLE="fork"/>
          </node>
        </node>
        <node TEXT="set speed" ID="8ad055ced516297947ba03edf4b86903" STYLE="fork">
          <node TEXT="速度范围" ID="a77d957562bc238b637c5f570a6c1ac4" STYLE="fork">
            <node TEXT="Max，EU：180，CN：130" ID="6dde32ffeabbf62151604294858084de" STYLE="fork"/>
            <node TEXT="Min, NP/PSP：30，NOP+：20" ID="d7ef3e76d5d6d19c79430458251e12e4" STYLE="fork"/>
          </node>
          <node TEXT="表显车速转实际车速" ID="2925233f0868dfe84884366df26bb30d" STYLE="fork"/>
          <node TEXT="+/-按键长拨还是短拨" ID="7f8457c7f28bf848c90cd950afaa90e3" STYLE="fork"/>
          <node TEXT="获取加速踏板override状态" ID="a2b06d27bbdadeefda2239c2d7b59517" STYLE="fork"/>
          <node TEXT="是否是智能限速区域" ID="b49041c9ba01919ba6f094f2a1dacaf6" STYLE="fork">
            <node TEXT="EU：所有都是" ID="ab5b03fa096b6235b187f7096fa9fcc6" STYLE="fork"/>
            <node TEXT="CN：高速，NOP+限速有效" ID="a577f67353f33f8ec3bf5d464a04bcad" STYLE="fork"/>
          </node>
          <node TEXT="更新限速信息（np/nop+）" ID="129e05a83b1a92a147f500cf971d3fee" STYLE="fork">
            <node TEXT="iAcc限速= min(电子眼限速，经验限速）优先于 法规限速" ID="c7a8a611600364c1f0dd6eb6387ae4db" STYLE="fork"/>
            <node TEXT="SAS限速 = 电子眼限速 优先于 法规限速" ID="5131de3f270352fa6cd0d7c1c86313b9" STYLE="fork"/>
          </node>
          <node TEXT="计算下段限速的减速距离" ID="952e7e53bf08d077e3abbd0b21eb928a" STYLE="fork">
            <node TEXT="nop+/np：0.5*((限速-表显)/减速度(0.8mpss)+反应时间(1s))*(表显+限速)" ID="5033902792d920eb9f6bbfb5775a57ca" STYLE="fork"/>
            <node TEXT="psp/urban： ((限速-表显)/减速度(1mpss)+反应时间(1s))*表显" ID="780d6bcc9a89a54f023ab41f5c3c8181" STYLE="fork"/>
          </node>
          <node TEXT="雨天模式" ID="3c71dea8e83db85721784b2b1f0ea729" STYLE="fork">
            <node TEXT="车速 &gt; 105kph：限速为105" ID="6dbc58ceb75c833d9b387b8cecbf73ca" STYLE="fork"/>
            <node TEXT="车速 &gt; 90kph：限速为90" ID="c8364899b5f581949c06f8c282606326" STYLE="fork"/>
          </node>
          <node TEXT="nop+-&gt;np，还是np-&gt;nop+？" ID="a9914e0ca7266eb6674d2ff26c48a88c" STYLE="fork"/>
        </node>
      </node>
    </node>
  </node>
</map>