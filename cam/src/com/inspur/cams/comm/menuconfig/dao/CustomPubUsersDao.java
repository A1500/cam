package com.inspur.cams.comm.menuconfig.dao;

import java.sql.Types;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.apache.http.impl.cookie.DateUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.comm.util.DateUtil;

/**
 * @Path com.inspur.cams.comm.menuconfig.cmd.CustomPubUsersQueryCmd
 * @Description: TODO 查询BSP用户
 * @author xuexzh
 */
public class CustomPubUsersDao extends BaseJdbcDao {

	public CustomPubUsersDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	/**
	 * 查询密码未修改天数
	 * 
	 * @param userId
	 * @return
	 */
	public String queryUserExpiredTime(String userId, String expiredDays) {
		StringBuffer sql = new StringBuffer();
		try {
			if (StringUtils.isNotEmpty(userId)) {
				sql.append("SELECT * FROM PUB_USERS WHERE USER_ID=?");
				int[] types = new int[] { Types.VARCHAR };
				Object[] args = new Object[] { userId };
				DataSet ds = executeDataset(sql.toString(), types, args, true);
				if (ds.getCount() == 1) {
					Record record = ds.getRecord(0);
					String lastTime = "";
					String createTime = (String)record.get("CREATE_TIME");
					String pwsUptTime = (String)record.get("PWD_UPT_TIME");
					if(createTime != null && createTime.length()>=8)
						createTime = createTime.substring(0, 8);
					else 
						createTime = null;
					if(pwsUptTime != null && pwsUptTime.length()>=8)
						pwsUptTime = pwsUptTime.substring(0, 8);
					else 
						pwsUptTime = null;
					
					Pattern pattern = Pattern.compile("\\d{8}");
					if(createTime != null && !pattern.matcher(createTime).matches()) {
						createTime = null;
					}
					if(pwsUptTime != null && !pattern.matcher(pwsUptTime).matches()) {
						pwsUptTime = null;
					}
					if (createTime != null && pwsUptTime == null) {
						lastTime = createTime;
					} else if (createTime != null && pwsUptTime != null) {
						lastTime = pwsUptTime;
					}
					if (!"".equals(lastTime)) {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
						Date lastDay;
						lastDay = sdf.parse(lastTime.substring(0, 8));
						lastDay.setTime(lastDay.getTime() + 1000 * 3600 * 24 * Long.parseLong(expiredDays));

						Date today = new Date();
						today.setHours(0);
						today.setMinutes(0);
						today.setSeconds(0);
						long between_days = (lastDay.getTime() - today.getTime()) / (1000 * 3600 * 24);
						return Integer.parseInt(String.valueOf(between_days)) + "";
					}
				}
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return "ERROR";
	}

	@Override
	protected void initDao() {
	}
}
