package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamApplyNotice;
/**
 * @title:公示结果信息Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamApplyNoticeDomain {
	/**
	 * 查询公示结果
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加公示结果
	 * @param samApplyNotice
	 */
	@Trans
	public void insert(SamApplyNotice samApplyNotice);
	
	/**
	 * 更新公示结果
	 * @param samApplyNotice
	 */
	@Trans
	public void update(SamApplyNotice samApplyNotice);
	
	/**
	 * 删除公示结果
	 */
	@Trans
	public void delete(String noticeId);
}
