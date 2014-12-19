package com.inspur.cams.bpt.base.domain;

import java.util.List;

import org.loushang.next.data.*;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;

/**
 * @title:IBptBaseinfoPeopleDomain
 * @description:
 * @author:
 * @since:2011-05-13
 * @version:1.0
*/
 public interface IBptBaseinfoPeopleDomain {

    public void saveBaseinfoPeople(List<BaseinfoPeople> list);
	@Trans
	public void saveList(BaseinfoPeople baseinfopeople, BaseinfoFamily baseinfofamily);
	public void updateList(BaseinfoPeople baseinfoPeople,BaseinfoFamily baseinfoFamily);
	public DataSet queryBaseinfoPeople(ParameterSet pset);
	
	 /**
	  *   查询家庭信息
	  * @param pset
	  * @return
	  */
	public DataSet queryBaseinfoFamily(ParameterSet pset);
	
	/**
	 * 添加人员信息
	 */
	public void insertPeople(BaseinfoPeople baseinfopeople);
	
	/**
	 * 更新人员信息
	 */
	public void updateBaseinfoPeople(BaseinfoPeople baseinfopeople);
	
	/**
	 * 更新家庭信息
	 */
	public void updateBaseinfoFamily(BaseinfoFamily baseinfofamily);
	/**
	 * 在乡复员
	 */
	public DataSet queryDemobilizedFlowHeader(String peopleId);
 }