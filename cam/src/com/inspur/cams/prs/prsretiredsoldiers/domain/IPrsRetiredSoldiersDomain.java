package com.inspur.cams.prs.prsretiredsoldiers.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.prs.prsawardsmeritorious.dao.PrsAwardsMeritorious;
import com.inspur.cams.prs.prsretiredsoldiers.dao.PrsRetiredSoldiers;
import com.inspur.cams.prs.prssoldiersarmy.dao.PrsSoldiersArmy;

public interface IPrsRetiredSoldiersDomain {
	/**
	 * 保存退役士兵基本信息到数据库
	 * @param soldier
	 * */
	void saveSoldier(PrsRetiredSoldiers soldier);

	/**
	 * 级联删除数据库中基本信息主键为id的士兵信息
	 * @param id
	 */
	void delete(String id);
	
	/**
	 * 新增退役士兵信息时，保存退役士兵基本信息、部队信息及立功授奖情况到数据库
	 * @param soldier 士兵基本情况
	 * @param army 部队信息
	 * @param awards 立功授奖情况
	 */
	@Trans
	void saveBaseInfo(PrsRetiredSoldiers soldier, PrsSoldiersArmy army,
			List<PrsAwardsMeritorious> awards);

	/**
	 * 更新数据库中退役士兵的基本信息
	 * @param soldier
	 */
	@Trans
	void updateSoldier(PrsRetiredSoldiers soldier);

	/**
	 * 审核退役士兵基本信息
	 * @param id 退役士兵基本信息id
	 */
	@Trans
	void approval(String id);

	/**
	 * 更新数据库中退役士兵的部队信息
	 * @param army
	 */
	@Trans
	void updataArmy(PrsSoldiersArmy army);

	/**
	 * 更新数据库中退役士兵的立功授奖情况
	 * @param awards
	 */
	@Trans
	void updataAwards(String id,List<PrsAwardsMeritorious> awards);

	/**
	 * 上报未审核退役士兵信息
	 * @param id
	 */
	@Trans
	void sendUp(String id);

	/**
	 * 批量更新退役士兵信息
	 * @param list
	 */
	@Trans
	void updateSoldiers(List<PrsRetiredSoldiers> list);
	/**
	 * 查询未下发的退役士兵信息
	 */
	public DataSet queryBatchSoldiers(ParameterSet pset);
	
	/**
	 * 查询复原干部和伤病残士兵信息
	 * @param pset
	 * @return
	 */
	
	public  DataSet querySoldiers(ParameterSet pset);
	/**
	 * 军区或安置地查询统计
	 * @param pset
	 * @return
	 */
	public DataSet querySoldier(ParameterSet pset);
	/**
	 * 已下发士兵信息
	 */
	public  DataSet querySoldierss(ParameterSet pset);
	/**
	 * 更新士兵安置状态
	 * @param soldierId
	 */
	@Trans
	public void updatePlacementFlag(String soldierId);
	/**
	 * 更新士兵培训状态
	 * @param soldierId
	 */
	@Trans
	public  void updateTrainFlag(String soldierId);
	
	/**
	 * 更新士兵下发状态
	 */
	@Trans
	public void updateAllotFlag(String[] soldierIds );

	/**
	 * 查询统计---伤残士兵明细列表
	 * @param pset
	 * @return
	 */
    public DataSet queryDisabilitySoldiers(ParameterSet pset);

    /**
     * 查询统计---按军区，士兵明细列表
     * @param pset
     * @return
     */
	public DataSet queryMilitarySoldiers(ParameterSet pset);

	/**
	 * 查询统计---士兵安置  明细列表
	 * @param pset
	 * @return
	 */
	public DataSet queryPlacementSoldiers(ParameterSet pset);

	/**
	 * 查询统计---参加培训   明细列表
	 * @param pset
	 * @return
	 */
	public DataSet queryTrainingSoldiers(ParameterSet pset);

	/**
	 * 通过soldier_id 查询士兵信息
	 * @param pset
	 * @return
	 */
	DataSet querySoldierById(ParameterSet pset);
	/**
	 * 查询符合条件的士兵人数
	 * @param pset
	 * @return
	 */
	DataSet queryPeopleNum(ParameterSet pset);
	
	/**
	 * 查询计划内伤病残退役士兵安置明细
	 * @param pset
	 * @return
	 */
	DataSet queryDisabilityPlacement(ParameterSet pset);
	/**
	 * 退役士兵安置地明细表查询
	 * @author linyy
	 * @param pset
	 * @return
	 */
	public DataSet querySoldiersPlacement(ParameterSet pset);
	/**
	 * 退役士兵培训统计表查询
	 * @author linyy
	 * @param pset
	 * @return
	 */
	public DataSet querySoldiersTraining(ParameterSet pset);
}
