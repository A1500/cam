package com.inspur.cams.drel.sam.dao;

import java.math.BigDecimal;
import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.sam.data.SamApplyInfo;

/**
 * @title:低保申请审批信息dao接口
 * @description:
 * @author:	yanliangliang
 * @since:2012-05-02
 * @version:1.0
*/
 public interface ISamApplyInfoDao extends BaseCURD<SamApplyInfo>{
	public void save(List<SamApplyInfo> list);
	/**
	 * 更新照片
	 * @param photoId
	 * @param photoText
	 * @return
	 */
	public String updatePhoto(String photoId, String photoText);
	
	public DataSet queryDaiBan(ParameterSet pset);
	public DataSet queryYiBan(ParameterSet pset);
	public DataSet queryEnd(ParameterSet pset);
	public DataSet queryHis(ParameterSet pset);
	/**
	 * 调用存储过程把记录保存到备用表中
	 * @param applyInfo
	 */
	public void toDuplicateRecord(SamApplyInfo applyInfo);
	/**
	 * 根据主键删除业务信息
	 * @param applyId
	 */
	public void deleteSamApply(String applyId);

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
	public void deleteHisInfoByApplyAndFamilyId(String applyId, String familyId);
	
	public DataSet queryNoticePrintData(ParameterSet pset);
	/**
	 * 当救助金计算方式为补差的时候，自动计算户月保障金
	 * @param pset
	 */
	public BigDecimal getAssistanceMoney(ParameterSet pset);
	public void deleteHisPeople(String peopleId, String familyId);
	public void updateCurActId(String struId, String applyId);
	
	
	  public  DataSet queryExport(ParameterSet pset);
	  
	  
	  public void updateFamilyArchive(SamApplyInfo applyInfo);
	  
	  
	  public String exportToXml(ParameterSet pset);
	  
	  public  DataSet queryForExportPeople(ParameterSet pset);
	  
	  public  DataSet queryForPeopleDetail(ParameterSet pset);
	  
	  public  DataSet queryInTheWarranty(ParameterSet pset);
	  
	  public  DataSet queryInAssitanceDetail(ParameterSet pset);
	  
	  /**
		 * @param processType 查询待办和核对信息。
		 * @param actDefName 环节名称
		 * @param mysetwhere 自定义查询条件 形式如：String:value&String:value 日期区间为：String:value-value
		 * @return
		 */
	  public  DataSet queryDaiBanAndEnsure(ParameterSet pset);
}
 
