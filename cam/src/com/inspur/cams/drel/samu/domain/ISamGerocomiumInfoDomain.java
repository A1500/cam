package com.inspur.cams.drel.samu.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.samu.data.SamGerocomiumInfo;

/**
 * 敬老院基础信息domain
 * @author 
 * @date 2012-09-26
 */
public interface ISamGerocomiumInfoDomain {

	/**
	 * 查询 敬老院基础信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 敬老院基础信息
	 * @param pset
	 * @return
	 */
	public SamGerocomiumInfo get(String gerocomiumId);

	/**
	 * 增加 敬老院基础信息
	 * @param samGerocomiumInfo
	 */
	@Trans
	public void insert(SamGerocomiumInfo samGerocomiumInfo);
	
	/**
	 * 修改 敬老院基础信息
	 * @param samGerocomiumInfo
	 */
	@Trans
	public void update(SamGerocomiumInfo samGerocomiumInfo);
	
	/**
	 * 删除 敬老院基础信息
	 * @param gerocomium Id
	 */
	@Trans
	public void delete(String gerocomiumId);

	/**
	 * 删除 敬老院基础信息所有
	 * @param gerocomium Id
	 */
	@Trans
	public void deleteAll(String gerocomiumId);
	/**
	 * 更新老年份是否当前状态
	 * @param gerocomium Id
	 */
	@Trans
	public void updateOldYear(String recordId);
	
	/**
	 * 更新敬老院基础信息所有
	 * @param gerocomium Id
	 */
	@Trans
	public void updateGerocomium(Record recordGerocomium,Record[] recordRoom,Record[] recordBed,Record[] recordWorker);
	
	/**
	 * 保存敬老院基础信息所有
	 * @param gerocomium Id
	 */
	@Trans
	public void saveGerocomium(Record recordGerocomium,Record[] recordRoom,Record[] recordBed,Record[] recordWorker,String recordId);
	/**
	 * 查询 登记名册敬老院选项
	 * @param pset
	 * @return
	 */
	public DataSet queryGero(ParameterSet pset);
	/**
	 * 敬老院基本情况统计
	 * @param pset
	 * @return
	 */
	public DataSet reportGeroInfo(ParameterSet pset);
	
	/**
	 * 保存敬老院、房间、人员基本信息
	 * @param recordId
	 * @param samGerocomiumInfo
	 * @param recordWorker
	 */
	@Trans
	public SamGerocomiumInfo savesamGerocomiumInfo(String recordId,
			SamGerocomiumInfo samGerocomiumInfo, Record[] recordWorker);
}