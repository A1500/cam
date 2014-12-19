package com.inspur.cams.drel.samu.dao;

import java.math.BigDecimal;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.samu.data.SamGeroApply;

/**
 * 敬老院业务主表dao
 * @author 
 * @date 2012-10-24
 */
public interface ISamGeroApplyDao extends BaseCURD<SamGeroApply> {

	
	/**
	 * 查询 敬老院零花钱列表
	 * @param pset
	 * @return
	 */
	public DataSet queryMoneryList(ParameterSet pset);
	public DataSet queryClothList(ParameterSet pset);
	public DataSet queryMoneyDetail(ParameterSet pset);
	public DataSet queryClothDetail(ParameterSet pset);
	public DataSet queryPocketList(ParameterSet pset);
	public DataSet applyClothList(ParameterSet pset);
	public DataSet applyCheckList(ParameterSet pset);

	/**
	 * 查询 查体名册
	 * @param pset
	 * @return
	 */
	public DataSet queryList(ParameterSet pset);
	/**
	 * 增加查体信息
	 * @param pset
	 * @return
	 */
	public void insertCheck(String gerocomiumName,String checkDate,String checkResult);
	/**
	 * 维护名册时，弹出查询明细
	 * @param pset
	 * @return
	 */
	public DataSet queryCheckDetail(ParameterSet pset);

}