package com.inspur.cams.prs.prsretiredsoldiers.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * @title:IPrsRetiredSoldiersDao
 * @description:
 * @author:
 * @since:2011-08-18
 * @version:1.0
*/
 public interface IPrsRetiredSoldiersDao extends BaseCURD<PrsRetiredSoldiers>{
	public void save(List<PrsRetiredSoldiers> list);
	
	public void updateTrainFlag(String soldierId);
	
	 public void updatePlacementFlag(String soldierId);
	 
	 public void updateAllotFlag(String[] soldierIds );

    public DataSet queryBatchSoldiers(ParameterSet pset);
    
    public DataSet queryDisabilitySoldiers(ParameterSet pset);

	public DataSet queryMilitarySoldiers(ParameterSet pset);

	public DataSet queryPlacementSoldiers(ParameterSet pset);

	public DataSet queryTrainingSoldiers(ParameterSet pset);
	public DataSet querySoldierss(ParameterSet pset);
	public DataSet querySoldiers(ParameterSet pset);
	public DataSet querySoldier(ParameterSet pset);
	public DataSet querySoldierById(ParameterSet pset);
	public DataSet queryBySql(ParameterSet pset);

	/**
	 * 查询计划内伤病残退役士兵安置情况
	 * @param pset
	 * @return
	 */
	public DataSet queryDisabilityPlacement(ParameterSet pset);
	/**
	 * 退役士兵安置地明细表查询
	 * @author linyy
	 * @param pset
	 * @return
	 */
	public DataSet querySoldiersPlacement(ParameterSet pset);
	/**
	 * 退役士兵培训统计表查询
	 * @param pset
	 * @return
	 */
	public DataSet querySoldiersTraining(ParameterSet pset);
}

