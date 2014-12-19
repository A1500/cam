package com.inspur.cams.comm.extuser.webservice;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.baseinfo.dao.IBaseinfoPeopleDao;
import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.comm.extuser.domain.IComExtUserDomain;
import com.inspur.cams.comm.extuser.util.Constant;
import com.inspur.cams.comm.util.Axis2Utils;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.mbalance.dao.ISamMBalanceDao;
import com.inspur.cams.drel.mbalance.dao.ISamMedicalDetailExpenseDao;
import com.inspur.cams.drel.mbalance.dao.ISamMedicalPerDao;
import com.inspur.cams.drel.mbalance.dao.ISamMedicalTopLineDao;
import com.inspur.cams.drel.mbalance.data.BalanceInfo;
import com.inspur.cams.drel.mbalance.data.BalancePreReturn;
import com.inspur.cams.drel.mbalance.data.CheckReturn;
import com.inspur.cams.drel.mbalance.data.ExpenseDetail;
import com.inspur.cams.drel.mbalance.data.HospitalRecord;
import com.inspur.cams.drel.mbalance.data.OperationReturn;
import com.inspur.cams.drel.mbalance.data.SamMBalance;
import com.inspur.cams.drel.mbalance.data.SamMedicalDetailExpense;
import com.inspur.cams.drel.mbalance.data.SamMedicalTopLine;

/**
 * 医疗救助一站式结算系统发布WebServices，供保险系统调用接口实现
 * 
 * @author 路国隋 2011-10-17
 */
public class ComExtUserLoginService implements IComExtUserLoginService {

	private IComExtUserDomain comExtUserDomain = (IComExtUserDomain) ScaComponentFactory.getService(IComExtUserDomain.class, "comExtUserDomain/comExtUserDomain");
	public OperationReturn login(String userName, String userPassWord) {
		OperationReturn op = new OperationReturn();
		// 外部单位用户domain
		if (comExtUserDomain != null) {
			ComExtUser comExtUser = comExtUserDomain.getComExtUser(userName);
			if (comExtUser != null && userPassWord.equals(comExtUser.getPwd())) {
				if ("1".equals(comExtUser.getAccountStatus())) {
					Axis2Utils.getSession().setAttribute(Constant.CAMS_LOGIN_EXTUSER, comExtUser);
					op.setReturnCode("00000");
					op.setReturnCodeDes("登陆成功！");
				} else {
					op.setReturnCode("0L001");
					op.setReturnCodeDes("帐号被锁定，请联系管理员!");
				}
			} else {
				op.setReturnCode("0L002");
				op.setReturnCodeDes("用户名或密码错误!");
			}
		} else {
			op.setReturnCode("0L00X");
			op.setReturnCodeDes("登录出错!");
		}
		return op;
	}
	public OperationReturn logout(String userName) {
		// TODO Auto-generated method stub
		return null;
	}

	
}
