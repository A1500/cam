package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamApplyDiscussion;
/**
 * @title:评议结果Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamApplyDiscussionDomain {
	/**
	 * 查询评议结果
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加评议结果
	 * @param samApplyDiscussion
	 */
	@Trans
	public void insert(SamApplyDiscussion samApplyDiscussion);
	
	/**
	 * 更新评议结果
	 * @param samApplyDiscussion
	 */
	@Trans
	public void update(SamApplyDiscussion samApplyDiscussion);
}
