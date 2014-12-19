package com.inspur.cams.prs.prsproblemdeal.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.prs.prsproblemdeal.dao.PrsProblemDeal;
/**
 * 
 * @author jiangzhaobao
 * 
 *
 */
public interface IPrsProblemDealDomain {
	/**
	 * 新增问题处理
	 */
	@Trans
	public void insert(ParameterSet pset,MultipartRequestWrapper wrapRequest);
	/**
	 * 问题处理
	 */
	@Trans
	public void process(ParameterSet pset);
	/**
	 * 更新问题处理
	 */
	@Trans
	public void update(ParameterSet pset,MultipartRequestWrapper wrapRequest);
	/**
	 * 通告sql查看问题处理
	 */
	@Trans
	public DataSet queryBySql(ParameterSet pset);
	public DataSet querySql (String problemId);
	/**
	 * 查看问题处理
	 */
	public DataSet query(ParameterSet pset);
	/**
	 * 删除问题处理
	 */
	@Trans
	public void batchDelete(String[] delIds);
}
