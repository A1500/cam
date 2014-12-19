package com.inspur.cams.drel.sam.domain;

import java.math.BigDecimal;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.drel.sam.data.SamApplyInfo;
import com.inspur.cams.sorg.check.manage.trans;

/**
 * @title:低保申请审批信息Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamApplyInfoDomain {
	/**
	 * 查询低保申请审批信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	/**
	 * 增加低保申请审批信息
	 * @param samApplyInfo
	 */
	@Trans
	public void insert(SamApplyInfo samApplyInfo);
	/**
	 * 更新低保申请审批信息
	 * @param samApplyInfo
	 */
	@Trans
	public void update(SamApplyInfo samApplyInfo);
	/**
	 * 更新照片
	 * @param photoId
	 * @param photoText
	 * @return
	 */
	@Trans
	public String updatePhoto(String photoId, String photoText);
	/**
	 * 查询待办
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	public DataSet queryDaiBan(ParameterSet pset);
	/**
	 * 查询已办
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	public DataSet queryYiBan(ParameterSet pset);
	/**
	 * 查询结束
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @return
	 */
	public DataSet queryEnd(ParameterSet pset);
	/**
	 * 查询历史
	 */
	public DataSet queryHis(ParameterSet pset);
	/**
	 * 获取一条家庭和待遇信息关联的家庭信息
	 * @param FAMILY_ID
	 */
	public DataSet getSamFamily(ParameterSet pset);
	/**
	 * 调用存储过程把记录保存到备用表中
	 * @param applyInfo
	 */
	@Trans
	public void toDuplicateRecord(SamApplyInfo applyInfo);
	/**
	 * 根据主键删除业务信息
	 * @param applyId
	 */
	@Trans
	public void deleteSamApply(String applyId);
	/**
	* @Title: insertApplyFromEnsurey
	* @Description: TODO(从经济核对回填业务信息)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public void insertApplyFromEnsurey(ParameterSet set);

	/**
	* @Title: addCheck
	* @Description: TODO(审批时发起核对方法) void  
	* @param set
	* @throws
	* @author luguosui
	 */
	public void addCheck(ParameterSet set);
	/**
	 * 调用存储过程删除历史采集的信息
	 */
	@Trans
	public void deleteHisInfoByApplyAndFamilyId(String applyId, String familyId);
	
	public DataSet queryNoticePrintData(ParameterSet pset);
	/**
	 * 当救助金计算方式为补差的时候，获取最低生活标准
	 * @param pset
	 */
	public BigDecimal getAssistanceMoney(ParameterSet pset);
	/**
	 * 计算城市户月保障金
	 * @param baseinfoFamily
	 * @return
	 */
	public BigDecimal getCityAssistanceMoney(BaseinfoFamily baseinfoFamily) ;
	/**
	 * 计算农村户月保障金
	 * @param baseinfoFamily
	 * @return
	 */
	public BigDecimal getCountryAssistanceMoney(BaseinfoFamily baseinfoFamily);
	@Trans
	public void deleteHisPeople(String peopleId, String familyId);
	/**
	 * 更新apply表里面的关于curActId
	 * @param struId
	 * @param applyId
	 */
	@Trans
	public void updateCurActId(String struId, String applyId);
	
	
	public DataSet queryExport(ParameterSet pset);
	
	
	public void updateFamilyArchive(SamApplyInfo applyInfo);
	
	public DataSet queryRecheckToChange(ParameterSet pset);
	
	public  DataSet queryForExportPeople(ParameterSet pset);
	
	public  DataSet queryForPeopleDetail(ParameterSet pset);
	
	public  DataSet queryInTheWarranty(ParameterSet pset);
	
	public  DataSet queryInAssitanceDetail(ParameterSet pset);
	@Trans
	//批量保存
	public void batchInsert(List list);
}
