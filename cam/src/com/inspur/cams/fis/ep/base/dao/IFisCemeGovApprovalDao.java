package com.inspur.cams.fis.ep.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.fis.ep.base.data.FisCemeGovApproval;

/**
 * @title: IFisCemeGovApprovalDao
 * @description:公墓政府部门批准dao接口
 * @author:lidongdong(xxz)
 * @since:2011-11-11
 * @version:1.0
 */
public interface IFisCemeGovApprovalDao extends BaseCURD<FisCemeGovApproval> {
	public void save(List<FisCemeGovApproval> list);
}
