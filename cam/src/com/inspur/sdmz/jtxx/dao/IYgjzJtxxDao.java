package com.inspur.sdmz.jtxx.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.sdmz.jtxx.data.BaseinfoFamily;

/**
 * @title:IYgjzJtxxDao
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
 public interface IYgjzJtxxDao extends BaseCURD<BaseinfoFamily>{
	public void save(List<BaseinfoFamily> list);
	// 更新成员数量
	public void updatePeopleNum(String familyId) ;
	//更改当前环节
	public void updateCurrentActivity(String activity,String jtids,String createOrgan) ;
	//得到教育救助列表
	public List getNeedJyJzList(String familyId) ;
	// 得到事故救助列表
	public List getSgSsMoneyList(String familyId) ;
	// 得到医疗救助列表
	public List getMedicalJzList(String familyId) ;
	// 得到残疾救助列表
	public List getDeformityJzList(String familyId);
	// 得到已救助列表
	public List getAlreadyJzList(String familyId);


}

