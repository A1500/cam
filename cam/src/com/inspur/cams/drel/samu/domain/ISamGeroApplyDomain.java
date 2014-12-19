package com.inspur.cams.drel.samu.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.samu.data.SamGeroApply;

/**
 * 敬老院业务主表domain
 * @author 
 * @date 2012-10-24
 */
public interface ISamGeroApplyDomain {

	/**
	 * 查询 敬老院业务主表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 敬老院业务主表
	 * @param pset
	 * @return
	 */
	public SamGeroApply get(String applyId);

	/**
	 * 增加 敬老院业务主表
	 * @param samGeroApply
	 */
	@Trans
	public void insert(SamGeroApply samGeroApply);
	
	/**
	 * 修改 敬老院业务主表
	 * @param samGeroApply
	 */
	@Trans
	public void update(SamGeroApply samGeroApply);
	
	/**
	 * 删除 敬老院业务主表
	 * @param applyId
	 */
	@Trans
	public void delete(String applyId);
	/**@tr
	 * 批量增加 敬老院业务主表
	 * @param samGeroApply
	 */
	public void batchInsert(List<SamGeroApply> args);
	/**@tr
	 * 批量更新 敬老院业务主表
	 * @param samGeroApply
	 */
	public void batchUpdate(List<SamGeroApply> args);
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
	@Trans
	public void insertCheck(String gerocomiumName,String checkDate,String checkResult);
	/**
	 * 维护查体名册时，弹出查询明细
	 * @param pset
	 * @return
	 */
	public DataSet queryCheckDetail(ParameterSet pset);
	/**
	 * 维护查体名册时，更新查体信息
	 * @param pset
	 * @return
	 */
	@Trans
	public void saveCheck(Record[] records);
	/**
	 * 删除查体名册时
	 * @param pset
	 * @return
	 */
	@Trans
	public void deleteCheckList(String gerocomiumId,String checkDate);
	/**@tr
	 * 查询 敬老院零花钱列表
	 * @param pset
	 * @return
	 */
	public DataSet queryMoneryList(ParameterSet pset);
	/**@tr
	 *  敬老院零花钱统计
	 * @param pset
	 * @return
	 */
	public DataSet queryPocketList(ParameterSet pset);
	/**@tr
	 * 敬老院服装统计
	 * @param pset
	 * @return
	 */
	public DataSet applyClothList(ParameterSet pset);
	/**@tr
	 * 敬老院查体统计
	 * @param pset
	 * @return
	 */
	public DataSet applyCheckList(ParameterSet pset);
	/**@tr
	 * 维护名册时，弹出发放查询明细
	 * @param pset
	 * @return
	 */
	public DataSet queryMoneyDetail(ParameterSet pset);
	/**@tr
	 * 查询 敬老院服装列表
	 * @param pset
	 * @return
	 */
	public DataSet queryClothList(ParameterSet pset);
	/**@tr
	 * 维护名册时，弹出服装发放查询明细
	 * @param pset
	 * @return
	 */
	public DataSet queryClothDetail(ParameterSet pset);
	
	/**@tr
	 * 维护名册时，更新发钱信息
	 * @param pset
	 * @return
	 */
	@Trans
	public void saveCheckM(Record[] records);
	/**@tr
	 * 维护名册时，更新发服装信息
	 * @param pset
	 * @return
	 */
	@Trans
	public void saveCheckCloth(Record[] records);
}