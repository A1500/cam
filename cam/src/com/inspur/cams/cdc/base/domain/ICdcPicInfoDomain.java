package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcPicInfo;

/**
 * 社区图片展示domain接口
 * @author shgtch
 * @date 2012-2-7
 */
public interface ICdcPicInfoDomain {

	/**
	 * 查询社区图片展示
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加社区图片展示
	 * @param cdcPicInfo
	 */
	@Trans
	public void insert(CdcPicInfo cdcPicInfo);
	
	/**
	 * 修改社区图片展示
	 * @param cdcPicInfo
	 */
	@Trans
	public void update(CdcPicInfo cdcPicInfo);
	
	/**
	 * 删除社区图片展示
	 * @param id
	 */
	@Trans
	public void delete(String id);
	
	public DataSet queryPicInfo(ParameterSet pset);

}