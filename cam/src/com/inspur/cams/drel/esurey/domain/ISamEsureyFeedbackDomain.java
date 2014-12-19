package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
/**
 * @title:SamEsureySocialDomain
 * @description:经济核对_外部单位填报信息domain接口
 * @author:luguosui
 * @since:2011-06-30
 * @version:1.0
*/
import com.inspur.cams.drel.esurey.data.SamEsureyFeedback;

public interface ISamEsureyFeedbackDomain {
	public DataSet query(ParameterSet pset);

	public void batchDelete(String[] delIds);

	public void update(SamEsureyFeedback dataBean);

	public void insert(SamEsureyFeedback dataBean);

	public void save(List<SamEsureyFeedback> list);
	 //更新经济核对_外部单位填报信息表中提交标志
	public void updateCheckFlg(ParameterSet paramSet);
}
