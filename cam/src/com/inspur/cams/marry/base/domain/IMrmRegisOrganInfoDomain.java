package com.inspur.cams.marry.base.domain;

import java.math.BigDecimal;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.base.data.MrmRegisArea;
import com.inspur.cams.marry.base.data.MrmRegisOrganInfo;
import com.inspur.cams.marry.base.data.MrmResourcesInfo;

/**
 * @title:IMrmRegisOrganInfoDomain
 * @description:
 * @author:
 * @since:2011-11-26
 * @version:1.0
*/
 public interface IMrmRegisOrganInfoDomain {
	public DataSet getOrganInfo(ParameterSet pset);
    public DataSet query(ParameterSet pset);
    public void insertAllPerson();
    public MrmRegisOrganInfo insert(MrmRegisOrganInfo dataBean,List<MrmRegisArea> areaList, List<MrmResourcesInfo> resourceList);
    public void saveMrmRegisOrganInfo(List<MrmRegisOrganInfo> list);
	public void saveMrmRegisArea(List<MrmRegisArea> list);
	public DataSet queryMrmRegisArea(ParameterSet pset);
	public void saveMrmRegisAreaList(MrmRegisOrganInfo mrmregisorganinfo, List<MrmRegisArea> list);

	
	public void saveMrmResourcesInfo(List<MrmResourcesInfo> list);
	public DataSet queryMrmResourcesInfo(ParameterSet pset);
	public void saveMrmResourcesInfoList(MrmRegisOrganInfo mrmregisorganinfo, List<MrmResourcesInfo> list);

	

	public DataSet queryMrmRegisOrganInfo(ParameterSet pset);


	public void delete(List<String> list);
	public MrmRegisOrganInfo update(MrmRegisOrganInfo dataBean,List<MrmRegisArea> areaList, List<MrmResourcesInfo> resourceList);

	
	/**
	 * 查询婚姻登记处列表
	 * @param pset
	 * @return
	 */
	public DataSet queryOrganInfoList(ParameterSet pset) ;
	
	
	/**
	 * 查询总面积
	 * @param deptId
	 * @return
	 */
	public BigDecimal getCountArea(String deptId);
	public void updateWithFile(MrmRegisOrganInfo mrmRegisOrganInfo);
	/**
	 * 查询所有带等级的登记处
	 * @return
	 */
	public DataSet queryLevelOrgan(ParameterSet pset);
	public void setLevel(String applyLevel, String organCode);
 }